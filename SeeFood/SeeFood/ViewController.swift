//
//  ViewController.swift
//  SeeFood
//
//  Created by Saurabh Kumar Verma on 13/08/2023.
//

import UIKit
import CoreML
import Vision
// Vision Help us in process images more easily. Allow images to work with core ML without writing whole lot of code.

class ViewController: UIViewController {
    
    @IBOutlet weak var imageView: UIImageView?
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker.delegate = self
        
        //        imagePicker.sourceType = .camera
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false  // allows user to crop images
        imagePicker.view.layoutIfNeeded()
    }
    
    func detect(image: CIImage) {
        // VNCoreMLModel is a container for ML Model
        guard let mlModel = try? Inceptionv3(configuration: .init()).model,
              let model = try? VNCoreMLModel(for: mlModel) else {
            fatalError("Loading CoreML model Failed.")
        }
        
        // creating request to our MLmodel
        let request = VNCoreMLRequest(model: model) { (request, error) in
            // Now the process the result of the request
            // VNClassificationObservation is a class that holds classification Observation after our model get processed.
            guard let results = request.results as? [VNClassificationObservation] else {
                fatalError("Model failed to process image.")
            }
            // print(results)
            if let firstResult = results.first {
                if firstResult.identifier.contains("hotdog") {
                    self.navigationItem.title = "HotDog!"
                } else {
                    self.navigationItem.title = "Not HotDog!"
                }
            }
        }
        
        // passing image to out model
        let handler = VNImageRequestHandler(ciImage: image)
        do {
            try handler.perform([request])
        } catch  {
            print(error.localizedDescription)
        }
        
    }
}


// MARK: - UIImagePickerControllerDelegate
extension ViewController: UIImagePickerControllerDelegate {
    
    // tells the delegate that the user picked a still image/movie.
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let userPickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            DispatchQueue.main.async {
                self.imageView?.image = userPickedImage
            }
            
            // CIImage (CoreImage Image). This is a special type of image that allow us to use the Vision framework and the coreML framework in order to get interpretation from it.
            guard let ciimage = CIImage(image: userPickedImage) else {
                fatalError("Couldn't convert the Image into CIImage.")
            }
            
            detect(image: ciimage)
        }
        
        // dismiss the image picker
        imagePicker.dismiss(animated: true)
    }
    
    @IBAction func imagePickButtonPressed(_ sender: UIBarButtonItem) {
        present(imagePicker, animated: true)
    }
}

extension ViewController: UINavigationControllerDelegate {
    
}

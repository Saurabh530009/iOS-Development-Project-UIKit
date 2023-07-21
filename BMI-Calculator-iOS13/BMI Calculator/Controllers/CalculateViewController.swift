//
//  ViewController.swift
//  BMI Calculator
//
//  Created by Angela Yu on 21/08/2019.
//  Copyright © 2019 Angela Yu. All rights reserved.
//

import UIKit

class CalculateViewController: UIViewController {
    
    // MARK:- IBOutlet
    @IBOutlet weak var heightLabel: UILabel?
    @IBOutlet weak var weightLabel: UILabel?
    @IBOutlet weak var heightSlider: UISlider?
    @IBOutlet weak var weightSlider: UISlider?
    
    var calculatorBrain = CalculatorBrain()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    // MARK:- IBAction
    @IBAction func heightSliderChanged(_ sender: UISlider) {
        heightLabel?.text = String(format: "%.2f", sender.value) + "m"
    }
    
    @IBAction func weightSliderChanged(_ sender: UISlider) {
        weightLabel?.text = "\(Int(sender.value))Kg"
    }
    @IBAction func calculatePressed(_ sender: UIButton) {
        guard let height = heightSlider?.value else {
            return
        }
        guard let weight = weightSlider?.value else {
            return
        }
        
        let _ = calculatorBrain.calculateBMI(weight: weight, height: height)
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
        // print(bmi)
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToResult"){
            let destinationVC = segue.destination as? ResultViewController
            destinationVC?.bmiValue = calculatorBrain.getBMIValue()
            destinationVC?.advice = calculatorBrain.getAdvice()
            destinationVC?.color = calculatorBrain.getColor()
        }
    }

}


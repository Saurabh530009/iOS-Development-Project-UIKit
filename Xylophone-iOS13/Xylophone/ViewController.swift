//
//  ViewController.swift
//  Xylophone
//
//  Created by Angela Yu on 28/06/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player : AVAudioPlayer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }


    @IBAction func keyPressed(_ sender: UIButton) {
        
        //Reduces the sender's (the button that got pressed) opacity to half.
        sender.alpha = 0.5
        
        //Code should execute after 0.2 second delay.
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.2) {
            //Bring's sender's opacity back up to fully opaque.
            sender.alpha = 1.0
        }
        
        
        // print("I got pressed")
        // print(sender.titleLabel?.text)
        
        guard let btnPressedName = sender.titleLabel?.text
        else{
            return
        }
        playSound(soundName : btnPressedName)
    }
    
    // Code to play sound
    func playSound(soundName : String) {
        // print(soundName)
        guard let path = Bundle.main.path(forResource: soundName, ofType:"wav")
        else {
            return
        }
        
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch let error {
            print(error.localizedDescription)
        }
    }
}


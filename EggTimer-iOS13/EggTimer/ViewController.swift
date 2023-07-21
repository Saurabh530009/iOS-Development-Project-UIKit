//
//  ViewController.swift
//  EggTimer
//
//  Created by Angela Yu on 08/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController {
    var player : AVAudioPlayer?
    let eggTime : [String : Int] = ["Soft" : 3, "Medium" : 5, "Hard" : 7]
    var timer = Timer()
    var totalTime = 0
    var secondsPassed = 0

    @IBOutlet weak var progressBar: UIProgressView?
    @IBOutlet weak var tittleLabel: UILabel?
    @IBAction func hardnessSelected(_ sender: UIButton) {
        // print(sender.currentTitle!)
                
        timer.invalidate()
        guard let eggName = sender.currentTitle
        else{
            return
        }
        
        progressBar?.progress = 0.0
        secondsPassed = 0
        tittleLabel?.text = eggName
        
        // print(eggName)
        // print(eggTime[eggName]!)
        
        totalTime = eggTime[eggName]!
        timer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(updateCounter), userInfo: nil, repeats: true)
    }
    
    // This will print the remaining seconds
    @objc func updateCounter() {
        // example functionality
        if secondsPassed < totalTime {
            // print("\(secondsPassed) seconds")
            
            secondsPassed += 1
            progressBar?.progress = Float(secondsPassed) / Float(totalTime)
        }
        else{
            playSound()
            timer.invalidate()
            tittleLabel?.text = "Done!"
        }
    }
    
    func playSound() {
        guard let path = Bundle.main.path(forResource: "alarm_sound", ofType:"mp3") else {
            return }
        let url = URL(fileURLWithPath: path)

        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
            
        } catch let error {
            print(error.localizedDescription)
        }
    }
}

//
//  ViewController.swift
//  Destini-iOS13
//
//  Created by Angela Yu on 08/08/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var storyLabel: UILabel?
    @IBOutlet weak var choice1Button: UIButton?
    @IBOutlet weak var choice2Button: UIButton?
    
    var story0 = "You are fork in the road..."
    var choice1 = "Take a left."
    var choice2 = "Take a right."
    
    var storyBrain = StoryBrain()
        
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateUI()
    }
    
    @IBAction func choiceMade(_ sender: UIButton) {
        guard let userChoice = sender.currentTitle else{
            return
        }
        storyBrain.nextStory(userChoice: userChoice)
        updateUI()
        
    }
    func updateUI() {
        storyLabel?.text = storyBrain.getStory()
        choice1Button?.setTitle(storyBrain.getChoice1Tittle(), for: .normal)
        choice2Button?.setTitle(storyBrain.getChoice2Tittle(), for: .normal)
    }
}

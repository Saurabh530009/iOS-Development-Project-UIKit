//
//  ViewController.swift
//  Dicee-iOS13
//
//  Created by Angela Yu on 11/06/2019.
//  Copyright © 2019 London App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // IBOutlet allows me to reference a UI element
    @IBOutlet weak var diceImageView1: UIImageView?
    @IBOutlet weak var diceImageView2: UIImageView?
    
    let arr : [String] = ["DiceOne", "DiceTwo", "DiceThree", "DiceFour", "DiceFive", "DiceSix"]
    var leftDiceNumber = 5
    var rightDiceNumber = 3
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        // Notation to change the value of some IBOutlet Variable
        // Who.What=Value
        
        /*diceImageView1?.image = UIImage(named: "DiceSix")
        diceImageView2?.image = UIImage(named: "DiceFour")*/
        diceImageView1?.alpha = 0.5
        
    }


    // Interface Builder Action
    @IBAction func rollBtnPressed(_ sender: UIButton) {
        print("Button got tapped.")

        diceImageView1?.image = UIImage(named: arr[leftDiceNumber])
        diceImageView2?.image = UIImage(named: arr[rightDiceNumber])
        
        /*leftDiceNumber = (leftDiceNumber + 1) % 6
        rightDiceNumber = (rightDiceNumber - 1 + 6) % 6 */
        
        // Generating a random number from 0 to 5, both inclusive
        leftDiceNumber = Int.random(in: 0...5)
        rightDiceNumber = Int.random(in: 0...5)
    }
}


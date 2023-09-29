//
//  ViewController.swift
//  Calculator Layout iOS13
//
//  Created by Angela Yu on 01/07/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel?
    private var isFinishedTypingNumber: Bool = true
    
    var calculator = CalculatorLogin()
    
    private var displayValue: Double {
        get {
            if let displayNumber = displayLabel?.text {
                guard let number = Double(displayNumber) else {
                    fatalError("Can't convert display label text to a Double.")
                }
                return number
            } else {
                fatalError("Can't convert displayLabel")
            }
        }
        set {
            displayLabel?.text = String(newValue)
        }
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        displayLabel?.text = ""
    }
    
    @IBAction func calcButtonPressed( _ sender: UIButton) {
        
        // What happen when non-number button pressed
        isFinishedTypingNumber = true
        calculator.setNumber(displayValue)
        if let calcMethod = sender.currentTitle {
            guard let result = calculator.calculate(symbol: calcMethod) else {
                fatalError("Calculation of the result is nil")
            }
            displayValue = result
        }
    }
        
    @IBAction func numButtonPressed(_ sender: UIButton) {
        // what should happen when a number is entered into the keypad
        if let numPressed = sender.currentTitle {
            if isFinishedTypingNumber {
                displayLabel?.text = numPressed
                isFinishedTypingNumber = false
            } else {
                if numPressed == "." {
                    
                    let isInt = floor(displayValue) == displayValue
                    
                    if !isInt {
                        return
                    }
                }
                displayLabel?.text! += numPressed
            }
            print(numPressed)
        }
    }
}


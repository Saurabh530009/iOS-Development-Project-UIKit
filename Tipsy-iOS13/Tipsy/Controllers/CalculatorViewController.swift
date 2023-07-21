//
//  ViewController.swift
//  Tipsy
//
//  Created by Angela Yu on 09/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class CalculatorViewController: UIViewController {
    // MARK:- IBOutlet
    @IBOutlet weak var billTextField: UITextField?
    @IBOutlet weak var zeroPctVButton: UIButton?
    @IBOutlet weak var tenPctButton: UIButton?
    @IBOutlet weak var twentyPctButton: UIButton?
    @IBOutlet weak var splitNumberLabel: UILabel?
    
    var tip = 0.10
    var splitPerPerson: String?
    
    // MARK:- IBAction
    @IBAction func tipChanged(_ sender: UIButton) {
        billTextField?.endEditing(true)
        
        // Deselect all the tip buttons via IBOutlet
        zeroPctVButton?.isSelected = false
        tenPctButton?.isSelected = false
        twentyPctButton?.isSelected = false
        
        // Make the button that triggered the IBAction selected
        sender.isSelected = true
        
        // Get the current tittle of the button that was pressed
        let buttonTittle = sender.currentTitle ?? "%"
        
        // Remove the last character(%) from the tittle the turn it back into a String
        let buttonTitleMinusPercentageSign = String(buttonTittle.dropLast())
        
        // Turn the string inton a Double
        let buttonTitleAsNumber = Double(buttonTitleMinusPercentageSign) ?? 0.0
        
        // Divide the percentage expressed out of 100 inot a decimal e.g. 10 becomes 0.1
        tip = buttonTitleAsNumber / 100
    }
    
    @IBAction func stepperValueChanged(_ sender: UIStepper) {
        splitNumberLabel?.text = String( Int(sender.value))
    }
    
    @IBAction func calculatePressed(_ sender: UIButton) {
        
//        print(tip)
        let totalPerson = Double(splitNumberLabel?.text ?? "0.0") ?? 0
        let total_Bill = Double(billTextField?.text ?? "0.0") ?? 0
        
        let val = (total_Bill * (1.0 + tip)) / totalPerson
        
        splitPerPerson = String(format: "%.2f", val)
        
        self.performSegue(withIdentifier: "goToResult", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "goToResult"){
            let destinationVC = segue.destination as? ResultsViewController
            destinationVC?.numberOfPeople = splitNumberLabel?.text
            destinationVC?.tipPercentage = "\(tip * 100)%"
            destinationVC?.splitPerPerson = splitPerPerson
        }
    }
}


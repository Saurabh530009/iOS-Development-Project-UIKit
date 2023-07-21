//
//  ResultViewController.swift
//  BMI Calculator
//
//  Created by Saurabh Kumar Verma on 07/07/2023.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

class ResultViewController: UIViewController {
    
    // MARK:- IBOutlet
    @IBOutlet weak var bmiLabel: UILabel?
    @IBOutlet weak var adviceLabel: UILabel?
    
    var bmiValue: String?
    var advice: String?
    var color: UIColor?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        bmiLabel?.text = bmiValue
        adviceLabel?.text = advice
        view.backgroundColor = color
    }
    
    // MARK:- IBAction
    @IBAction func recalculatePressed(_ sender: UIButton) {
        self.dismiss(animated: true)
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

//
//  ResultsViewController.swift
//  Tipsy
//
//  Created by Saurabh Kumar Verma on 09/07/2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import UIKit

class ResultsViewController: UIViewController {

    @IBOutlet weak var totalLabel: UILabel?
    @IBOutlet weak var settingsLabel: UILabel?
    
    var numberOfPeople : String?
    var tipPercentage : String?
    var splitPerPerson: String?

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        settingsLabel?.text = "Split between \(numberOfPeople ?? "0") people, with \(tipPercentage ?? "0") tip"
        totalLabel?.text = splitPerPerson
    }
    
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

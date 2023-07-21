//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var bitcoinLabel: UILabel?
    @IBOutlet weak var currencyLabel: UILabel?
    @IBOutlet weak var currencyPicker: UIPickerView?{
        didSet{
            currencyPicker?.dataSource = self
            currencyPicker?.delegate = self
        }
    }
    
    var coinManager = CoinManager()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Easily Missed: Must set the coinManager's delegate as this current class so that we can recieve
        //the notifications when the delegate methods are called.
        coinManager.delegate = self
    }
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate
extension ViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    // How many columns we wants in our picker
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    // Return String which is the title for a given row.
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    // This will get called every time when the user scrolls the picker. When that happens it will record the row number that was selected.
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
//        print(row)
//        print(coinManager.currencyArray[row])
        
        let selectedCurrency = coinManager.currencyArray[row]
        coinManager.getCoinPrice(for: selectedCurrency)
    }
}

// MARK: - CoinManagerDelegate
extension ViewController: CoinManagerDelegate {
    //Provide the implementation for the delegate methods.
        
        //When the coinManager gets the price it will call this method and pass over the price and currency.
    func didUpdatePrice(price: String, currency: String) {
            
            //Remember that we need to get hold of the main thread to update the UI, otherwise our app will crash if we
            //try to do this from a background thread (URLSession works in the background).
            DispatchQueue.main.async {
                self.bitcoinLabel?.text = price
                self.currencyLabel?.text = currency
            }
        }
    
    func didFailWithError(error: Error) {
        print(error)
    }
}


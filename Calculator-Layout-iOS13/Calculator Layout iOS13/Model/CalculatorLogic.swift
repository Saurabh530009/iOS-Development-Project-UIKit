//
//  CalculatorLogic.swift
//  Calculator Layout iOS13
//
//  Created by Saurabh Kumar Verma on 24/07/2023.
//  Copyright © 2023 The App Brewery. All rights reserved.
//

import Foundation

struct CalculatorLogin {
    
    private var number: Double?
    mutating func setNumber( _ number: Double) {
        self.number = number
    }
    
    func calculate(symbol: String) -> Double? {
        if let n = number {
            if symbol == "+/-" {
                return n * -1;
            }
            else if symbol == "AC" {
                return 0        }
            else if symbol == "%" {
                return  n * 0.01
            }
//            else if symbol = "+" {
//
//            }
//            else if symbol = "-" {
//
//            }
//            else if symbol = "x" {
//                
//            }
//            else if symbol = "÷" {
//
//            }
        }
        return nil
    }
}

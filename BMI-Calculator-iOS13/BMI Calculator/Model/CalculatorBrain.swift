//
//  CalculatorBrain.swift
//  BMI Calculator
//
//  Created by Saurabh Kumar Verma on 08/07/2023.
//  Copyright © 2023 Angela Yu. All rights reserved.
//

import UIKit

struct CalculatorBrain {
    
    var bmi : BMI?
    
    mutating func calculateBMI(weight: Float, height: Float) -> Float {
        let bmiValue = weight / (height * height)
        
        if (bmiValue < 18.5){
            bmi = BMI(value: bmiValue, advice: "Eat more pies", color: UIColor.systemBlue)
        }
        else if (bmiValue > 24.9){
            bmi = BMI(value: bmiValue, advice: "Eat less pies", color: UIColor.red)
        }
        else{
            bmi = BMI(value: bmiValue, advice: "Fire as a fiddle!", color: UIColor.green)
        }
        return bmiValue
    }
    func getBMIValue() -> String {
        let bmiTo1DecimalPlace = String(format: "%.1f", bmi?.value ?? 0.0)
        return bmiTo1DecimalPlace
    }
    
    func getAdvice() -> String {
        return bmi?.advice ?? "No advice"
    }
    
    func getColor() -> UIColor {
        return bmi?.color ?? UIColor.white
    }
}

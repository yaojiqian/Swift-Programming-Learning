//
//  ViewController.swift
//  Calculator
//
//  Created by Yao Jiqian on 12/8/15.
//  Copyright © 2015 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController
{
    
    //MARK: Properties
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var dotButton: UIButton!
    @IBOutlet weak var numberOfDigit: UITextField!
    
    var firstInputed : Bool = false
    var shouldReinputOperand : Bool = true
    var decimalPointEntered : Bool = false
    
    var brain = CalculatorBrain()
    
    var result : Double{
        get{
            let numberFormatter = NSNumberFormatter()
            numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
            numberFormatter.minimumFractionDigits = decimalNumber
            numberFormatter.maximumFractionDigits = decimalNumber
            if resultLabel.text!.isEmpty {
                return 0
            }else{
                return numberFormatter.numberFromString(resultLabel.text!)!.doubleValue
            }
        }
        
        set{
            let numberFormatter = NSNumberFormatter()
            numberFormatter.numberStyle = NSNumberFormatterStyle.DecimalStyle
            numberFormatter.minimumFractionDigits = decimalNumber
            numberFormatter.maximumFractionDigits = decimalNumber
            resultLabel.text = numberFormatter.stringFromNumber(newValue)
        }
    }
    
    var decimalNumber : Int
    {
        get{
            let digit = NSNumberFormatter().numberFromString(numberOfDigit.text!)
            return (digit?.integerValue)!
        }
    }

    func isUnaryOperation(operation op:String)->Bool{
        if op == "√" {
            return true
        }
        return false
    }
    
    
    
    //MARK: Actions
    @IBAction func operandPressed(sender: UIButton) {
        let digit = sender.currentTitle!
        if(shouldReinputOperand){
            resultLabel.text = digit
            shouldReinputOperand = false
        }else{
            if digit == "." {
                dotButton.enabled = false
                decimalPointEntered = true
            }
            resultLabel.text = resultLabel.text! + digit
        }
    }
    
    @IBAction func operatorPressed(sender: UIButton) {
        let opd = sender.currentTitle!
        
        if(firstInputed){
            brain.pushOperand(result)
            result = brain.performOperation(opd)!
            shouldReinputOperand = true
        }else{
            firstInputed = true
            brain.pushOperand(result)
            resultLabel.text = ""
            decimalPointEntered = false
            dotButton.enabled = true
            //if isUnaryOperation(operation: opd){
                if let r = brain.performOperation(opd) {
                    result = r
                }
            //}
        }
    }
    
    @IBAction func conformPressed(sender: UIButton) {
        
        let currentResult = resultLabel.text!
        
        if !currentResult.isEmpty {
            if(firstInputed){
                brain.pushOperand(result)
                firstInputed = false
            }
        }else{
            brain.pushOperand(result)
            firstInputed = false
        }
        
        result = brain.performOperation()!
        dotButton.enabled = true
        shouldReinputOperand = true
        
    }
    
    @IBAction func resetPressed(sender: UIButton) {
        firstInputed = false
        shouldReinputOperand = true
        dotButton.enabled = true
        decimalPointEntered = false
        resultLabel.text = ""
        brain.clear()
    }
}


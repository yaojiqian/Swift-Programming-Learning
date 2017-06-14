//
//  CalculatorBrain.swift
//  Calculator
//
//  Created by Yao Jiqian on 12/17/15.
//  Copyright © 2015 BigBit Corp. All rights reserved.
//

import Foundation

class CalculatorBrain
{
    //MARK: Enum
    private enum Op{
        case Operand(Double)
        case UnaryOperation(String, Double->Double)
        case BinaryOperation(String, (Double, Double)->Double)
    }
    
    
    //MARK: Properties
    private var operandStack = [Double]()
    private var lastOperator : Op? = nil
    private var lastOperand : Double = 0.0
    
    private var knownOps = [String: Op]()
    
    //MARK: Initializer
    init(){
        knownOps["+"] = Op.BinaryOperation("+", {$0 + $1})
        knownOps["−"] = Op.BinaryOperation("−", {$1 - $0})
        knownOps["×"] = Op.BinaryOperation("×", {$0 * $1})
        knownOps["÷"] = Op.BinaryOperation("÷", {$1 / $0})
        knownOps["√"] = Op.UnaryOperation("√", {sqrt($0)})
    }
    
    //MARK: Methods
    private func evalaute() -> Double?{
        switch lastOperator!{
        case .UnaryOperation(_ , let f):
            if operandStack.count >= 1 {
                let operand = operandStack.removeLast()
                let result = f(operand)
                operandStack.append(result)
                return result
            }else {
                return nil
            }
        case .BinaryOperation(_, let f):
            if operandStack.count >= 2 {
                let operand = operandStack.removeLast()
                let result = f(operand, operandStack.removeLast())
                operandStack.append(result)
                return result
            }else{
                return nil
            }
        default:
            return nil
        }
    }
    
//    func evalaute()->Double? {
//        
//        return nil
//    }
    
    func pushOperand(operand : Double){
        operandStack.append(operand)
        lastOperand = operand
    }
    
    func performOperation() -> Double? {
        return evalaute()
    }
    
    func performOperation(symbol: String)->Double?{
        if let operation = knownOps[symbol] {
            lastOperator = operation
            return evalaute()
        }
        return nil
    }
    
    func clear(){
        lastOperator = nil
        lastOperand = 0.0
        operandStack.removeAll()
    }
        
}
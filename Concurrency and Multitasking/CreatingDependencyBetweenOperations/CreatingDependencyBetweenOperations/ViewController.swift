//
//  ViewController.swift
//  CreatingDependencyBetweenOperations
//
//  Created by Yao Jiqian on 15/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    func performWorkWithParameter(param: AnyObject?, operationName: String){
        if let theParam : AnyObject = param{
            print("First Parameter - Object = \(theParam)")
        }
        
        print("\(operationName) operation - " + "Main Thread = \(Thread.main)")
        
        print("\(operationName) operation - " + "Current Thread = \(Thread.current)")
    }
    
    func firstOperationEntry(param : AnyObject?){
        performWorkWithParameter(param: param, operationName: "First")
    }
    
    func secondOperationEntry(param : AnyObject?){
        performWorkWithParameter(param: param, operationName: "Second")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let firstNumber = 111
        let secondNumber  = 222
        
        let firstOperation = BlockOperation(block: {[weak self] in
            if let strongSelf = self{
                strongSelf.firstOperationEntry(param: firstNumber as AnyObject)
            }
        })
        
        let secondOperation = BlockOperation(block: {[weak self] in
            if let strongSelf = self{
                strongSelf.secondOperationEntry(param: secondNumber as AnyObject)
            }
        })
        
        let operationQueue = OperationQueue()
        
        firstOperation.addDependency(secondOperation)
        
        operationQueue.addOperation(firstOperation)
        operationQueue.addOperation(secondOperation)
        
        print("Main Thread is here")
    }
}


//
//  ViewController.swift
//  CreatingSimpleConcurrencyWithOperations
//
//  Created by Yao Jiqian on 15/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    func operationCode(){
        for _ in 0..<100{
            print("Thead:\(Thread.current)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        //Using the subclass of Operation.
        let operation = CountingOperation(startCount: 3, endCount: 10)
        let operationQueue = OperationQueue()
        
        operationQueue.addOperation(operation)
        
        //Using BlockOperation
        let blockOperation1 = BlockOperation(block: self.operationCode)
        let blockOperation2 = BlockOperation(block: self.operationCode)
        
        operationQueue.addOperation(blockOperation1)
        operationQueue.addOperation(blockOperation2)
        
        
    }
}


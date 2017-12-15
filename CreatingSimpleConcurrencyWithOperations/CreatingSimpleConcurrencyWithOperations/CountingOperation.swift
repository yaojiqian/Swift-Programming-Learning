//
//  CountingOperation.swift
//  CreatingSimpleConcurrencyWithOperations
//
//  Created by Yao Jiqian on 15/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class CountingOperation : Operation
{
    var startingCout : Int = 0
    var endingCout : Int = 0
    
    init(startCount: Int, endCount: Int){
        startingCout = startCount
        endingCout = endCount
    }
    
    convenience override init(){
        self.init(startCount: 0, endCount: 3)
    }
    
    override func main(){
        var isTaskFinished = false
        
        while isTaskFinished == false && self.isFinished == false {
            for counter in startingCout..<endingCout{
                print("count:\(counter)")
                print("current thread:\(Thread.current)")
                print("main thread:\(Thread.main)")
                print("-----------------------------------")
            }
            isTaskFinished = true
        }
    }
}

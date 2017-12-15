//
//  ViewController.swift
//  PerformingTasksAfterADelay
//
//  Created by Yao Jiqian on 15/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var label : UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let delayInSeconds = 10.0
        //let delayInNanoSeconds = DispatchTime(uptimeNanoseconds: UInt64(delayInSeconds * Double(NSEC_PER_SEC)))
        let delayInNanoSeconds = DispatchTime.now() + DispatchTimeInterval.seconds(10)
        
        let currentQueue = DispatchQueue.global(qos: DispatchQoS.QoSClass.default)
        
        //asyncAfter need a deadline time, not the time interval.
        currentQueue.asyncAfter(deadline: delayInNanoSeconds, execute: {
            for  i in 0..<10{
                print("\(i)")
                sleep(1)
            }
        })
        
        label = UILabel(frame: CGRect(x: 100, y: 200, width: 100, height: 50))
        label?.text = "Hello Delay"
        view.addSubview(label!)
    }

}


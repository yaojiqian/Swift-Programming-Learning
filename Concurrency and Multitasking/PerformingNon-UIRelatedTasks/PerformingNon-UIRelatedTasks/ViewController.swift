//
//  ViewController.swift
//  PerformingNon-UIRelatedTasks
//
//  Created by Yao Jiqian on 21/09/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var label : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let queue = DispatchQueue.global(qos : DispatchQoS.QoSClass.background)
        //let queue2 = DispatchQueue.global(qos : DispatchQoS.QoSClass.background)
        //let queue3 = DispatchQueue.global(qos : DispatchQoS.QoSClass.background)
        queue.async(execute: {[weak self] in
            queue.sync {self!.printFrom1To1000()};
            queue.sync {self!.printFrom1To1000()}})

        //queue.sync{ self.printFrom1To1000() }
        //queue2.sync{ self.printFrom1To1000() }
        
        label = UILabel(frame: CGRect(x: 100, y: 200, width: 100, height: 50))
        label.text = "Hello"
        view.addSubview(label)
        
    }

    func printFrom1To1000(){
        for counter in 0..<10 {
            print("Counter = \(counter), current = \(Thread.current)")
            sleep(1)
        }
    }

}


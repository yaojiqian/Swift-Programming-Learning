//
//  ViewController.swift
//  Detecting Swipe Gestures
//
//  Created by Yao Jiqian on 25/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var swipeRecognizer : UISwipeGestureRecognizer!
    
    required init?(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)
        swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(handleSwipes))
        
    }
    
    func handleSwipes(sender : UISwipeGestureRecognizer){
        
        if sender.direction == .down {
            print("Swiped down")
        }
        if sender.direction == .left {
            print("Swiped left")
        }
        if sender.direction == .up {
            print("Swiped up")
        }
        if sender.direction == .right {
            print("Swiped right")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Swipes that are performed from right to left are to be detected */
        swipeRecognizer.direction = .up
        
        /* Just one finger needed */
        swipeRecognizer.numberOfTouchesRequired = 1
        
        /* Add it to the view */
        view.addGestureRecognizer(swipeRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


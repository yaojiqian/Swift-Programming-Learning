//
//  ViewController.swift
//  Detecting Panning and Dragging Gestures
//
//  Created by Yao Jiqian on 26/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var helloWorldLabel : UILabel!
    var panGestureRecognizer : UIPanGestureRecognizer!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        let labelFrame = CGRect(x: 0, y: 0, width: 150, height: 100)
        helloWorldLabel = UILabel(frame: labelFrame)
        /* Make sure to enable user interaction; otherwise, tap events won't be caught on this label */
        helloWorldLabel.isUserInteractionEnabled = true
        helloWorldLabel.text = "Hello, World!"
        helloWorldLabel.frame = labelFrame
        helloWorldLabel.backgroundColor = UIColor.black
        helloWorldLabel.textColor = UIColor.white
        helloWorldLabel.textAlignment = .center
        
        panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture))
    }

    func handlePanGesture(gesture: UIPanGestureRecognizer){
        
        if gesture.state != .ended && gesture.state != .failed {
            let location = gesture.location(in: gesture.view?.superview)
            gesture.view?.center = location
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Now make sure this label gets displayed on our view */
        view.addSubview(helloWorldLabel)
        
        /* At least and at most we need only one finger to activate the pan gesture recognizer */
        panGestureRecognizer.minimumNumberOfTouches = 1
        panGestureRecognizer.maximumNumberOfTouches = 1
        
        /* Add it to our view */
        helloWorldLabel.addGestureRecognizer(panGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


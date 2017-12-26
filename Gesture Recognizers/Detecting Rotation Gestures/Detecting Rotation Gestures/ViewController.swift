//
//  ViewController.swift
//  Detecting Rotation Gestures
//
//  Created by Yao Jiqian on 25/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var helloWorldLabel : UILabel!
    var rotationRecognizer : UIRotationGestureRecognizer!
    var rotationAngleInRadians = 0.0 as CGFloat
    
    required init?(coder aDecoder : NSCoder){
        super.init(coder: aDecoder)
        
        helloWorldLabel = UILabel()
        rotationRecognizer = UIRotationGestureRecognizer(target: self, action: #selector(handleRotation))
        
    }
    
    func handleRotation(recognizer : UIRotationGestureRecognizer){
        /* Take the previous rotation and add the current rotation to it */
        helloWorldLabel.transform = CGAffineTransform(rotationAngle: rotationAngleInRadians + recognizer.rotation)
        
        /* At the end of the rotation, keep the angle for later use */
        if recognizer.state == .ended{
            rotationAngleInRadians += recognizer.rotation
        }
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        helloWorldLabel.text = "Hello, World!"
        helloWorldLabel.font = UIFont.systemFont(ofSize: 16)
        helloWorldLabel.sizeToFit()
        helloWorldLabel.center = view.center
        view.addSubview(helloWorldLabel)
        
        view.addGestureRecognizer(rotationRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


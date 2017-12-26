//
//  ViewController.swift
//  Detecting Long Press Gestures
//
//  Created by Yao Jiqian on 26/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var longPressGestureRecognizer : UILongPressGestureRecognizer!
    var dummyButton : UIButton!
    
    /* Detecting Tap Gestures */
    var tapGestureRecognizer : UITapGestureRecognizer!
    
    /* Detecting Pinch Gestures */
    var myBlackLabel : UILabel!
    var pinchGestureRecognizer : UIPinchGestureRecognizer!
    var currentScale = 0.0 as CGFloat
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        dummyButton = UIButton.init(type: .system) as UIButton
        dummyButton.frame = CGRect(x: 0, y: 0, width: 72, height: 37)
        dummyButton.setTitle("My Button", for: .normal)
        
        /* First create the gesture recognizer */
        longPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(handleLongPressGesture))
        
        /* The number of fingers that must be present on the screen */
        longPressGestureRecognizer.numberOfTouchesRequired = 2
        
        /* Maximum 100 points of movement allowed before the gesture is recognized */
        longPressGestureRecognizer.allowableMovement = 100
        
        /* The user must press 2 fingers (numberOfTouchesRequired) for at least 1 second for the gesture to be recognized */
        longPressGestureRecognizer.minimumPressDuration = 1
        
        /* Detecting Tap Gestures */
        tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTaps))
        
        tapGestureRecognizer.numberOfTouchesRequired = 2
        
        /* Detecting Pinch Gestures */
        let labelRect = CGRect(x: 0, y: 0, width: 200, height: 200)
        myBlackLabel = UILabel(frame: labelRect)
        myBlackLabel.backgroundColor = UIColor.black
        /* Without this line, our pinch gesture recognizer will not work */
        myBlackLabel.isUserInteractionEnabled = true
        
        /* Create the Pinch Gesture Recognizer */
        pinchGestureRecognizer = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        
    }
    
    func handleLongPressGesture(gesture : UILongPressGestureRecognizer){
        
        /* Here we want to find the midpoint of the two fingers that caused the long-press gesture to be recognized. We configured this number using the numberOfTouchesRequired property of the UILongPressGestureRecognizer that we instantiated before. If we find that another long-press gesture recognizer is using this method as its target, we will ignore it */
        if gesture.numberOfTouches == 2 {
            let touchPoint1 = gesture.location(ofTouch: 0, in: gesture.view)
            let touchPoint2 = gesture.location(ofTouch: 1, in: gesture.view)
            
            let midPointX = (touchPoint1.x + touchPoint2.x) / 2.0
            let midPointY = (touchPoint1.y + touchPoint2.y) / 2.0
            
            let midPoint = CGPoint(x: midPointX, y: midPointY)
            
            dummyButton.center = midPoint
            
        }else{
            /* This is a long-press gesture recognizer with more or less than 2 fingers */
            let alterController = UIAlertController(title: "two fingers", message: "Please use two fingers", preferredStyle: .alert)
            
            alterController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            present(alterController, animated: true)
        }
        
    }
    
    func handleTaps(sender: UITapGestureRecognizer){
        for touchCounter in 0..<sender.numberOfTouchesRequired{
            let touchPoint = sender.location(ofTouch: touchCounter, in: sender.view)
            print("Touch \(touchCounter + 1): \(touchPoint)")
        }
    }

    func handlePinch(gesture : UIPinchGestureRecognizer){
        if gesture.state == .ended{
            currentScale = gesture.scale
        } else if gesture.state == .began && currentScale != 0.0{
            gesture.scale = currentScale
        }
        if gesture.scale != CGFloat.nan && gesture.scale != 0.0{
            gesture.view!.transform = CGAffineTransform.init(scaleX: gesture.scale, y: gesture.scale)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dummyButton.center = CGPoint(x: 100, y: 300)
        view.addSubview(dummyButton)
        
        /* Add this gesture recognizer to our view */
        view.addGestureRecognizer(longPressGestureRecognizer)
        
        /* Detecting Tap Gestures */
        view.addGestureRecognizer(tapGestureRecognizer)
        
        /* Pinch Gesture Recognizer */
        myBlackLabel.center = view.center
        view.addSubview(myBlackLabel)
        myBlackLabel.addGestureRecognizer(pinchGestureRecognizer)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


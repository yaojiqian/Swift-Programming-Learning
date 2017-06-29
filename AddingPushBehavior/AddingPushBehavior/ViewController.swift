//
//  ViewController.swift
//  AddingPushBehavior
//
//  Created by Yao Jiqian on 28/06/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var squareView : UIView?
    var animator : UIDynamicAnimator?
    var pushBehavior : UIPushBehavior?
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        createSmallSquareView()
        createAnimatorAndBehavior()
        createGestureRecognizer()
    }
    
    func createSmallSquareView(){
        squareView = UIView(frame: CGRect(x:0, y:0, width: 80, height: 80))
        if let theSquareView = squareView {
            theSquareView.backgroundColor = UIColor.green
            theSquareView.center = view.center
            view.addSubview(theSquareView)
        }
    }

    func createGestureRecognizer(){
        let tapGestureRecgnizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tapGestureRecgnizer)
    }
    
    func createAnimatorAndBehavior(){
        animator = UIDynamicAnimator(referenceView: view)
        
        if let theSquareView = squareView {
            let collisionBehavior = UICollisionBehavior(items: [theSquareView])
            collisionBehavior.translatesReferenceBoundsIntoBoundary = true
            
            pushBehavior = UIPushBehavior(items: [theSquareView], mode: .continuous)
            
            animator!.addBehavior(collisionBehavior)
            animator!.addBehavior(pushBehavior!)
        }
    }
    
    func handleTap(tap : UITapGestureRecognizer){
        /* Get the angle between the center of the square view and the tap point */
        let tapPoint = tap.location(in: view)
        let squareCenter = squareView!.center
        
        /* Calculate the angle between the center point of the square view and
         the tap point to find out the angle of the push
         Formula for detecting the angle between two points is:
         arc tangent 2((p1.x - p2.x), (p1.y - p2.y)) */
        let deltaX = tapPoint.x - squareCenter.x
        let deltaY = tapPoint.y - squareCenter.y
        let angle = atan2(deltaY, deltaX)
        
        pushBehavior!.angle = angle
        
        /* Use the distance between the tap point and the center of our square
         view to calculate the magnitude of the push
         Distance formula is:
         square root of ((p1.x - p2.x)^2 + (p1.y - p2.y)^2) */
        let distanceBetweenPoints = sqrt(pow(deltaX, 2.0) + pow(deltaY, 2.0))
        pushBehavior!.magnitude = distanceBetweenPoints / 200.0
    }
    
}


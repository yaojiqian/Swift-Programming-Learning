//
//  ViewController.swift
//  AddingGravity
//
//  Created by Yao Jiqian on 22/06/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    //var squareView : UIView?
    var squareViews = [UIView?]()
    var animator : UIDynamicAnimator?
    var pushBehavior : UIPushBehavior?

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /*
        /* Create our little square view and add it to self.view */
        squareView = UIView(frame: CGRect(x: 0, y: 0, width: 100, height: 100))
        if let theSquareView = squareView {
            theSquareView.backgroundColor = UIColor.green
            theSquareView.center.x = view.center.x
            view.addSubview(theSquareView)
        }
        */
        
        let colors = [UIColor.green, UIColor.red]
        var currentCenter = view.center
        let eachViewSize = CGSize(width: 50, height: 50)
        for i in 0..<2 {
            let newView = UIView(frame: CGRect(x:0, y: 0, width: eachViewSize.width, height: eachViewSize.height))
            newView.backgroundColor = colors[i]
            newView.center = currentCenter
            view.addSubview(newView)
            currentCenter.y += eachViewSize.height + 10
            
            squareViews.append(newView)
        }
        
        
        animator = UIDynamicAnimator(referenceView: view)
        if let theAnimator = animator {
            let gravityBehavior = UIGravityBehavior(items: squareViews as! [UIDynamicItem] )
            theAnimator.addBehavior(gravityBehavior)
            
            let collision = UICollisionBehavior(items: squareViews as! [UIDynamicItem])
            
            let boundary = view.bounds.insetBy(dx: 10, dy: 10)
            
            collision.addBoundary(withIdentifier: "Inset" as NSCopying, from: CGPoint(x: 10, y: 10), to: CGPoint(x: view.bounds.width / 2, y: view.bounds.height))
            collision.addBoundary(withIdentifier: "Underline" as NSCopying, from: CGPoint(x: 10, y: view.bounds.height), to: CGPoint(x: view.bounds.width , y: view.bounds.height))
            collision.addBoundary(withIdentifier: "LeftLine" as NSCopying, from: CGPoint(x: boundary.width, y: 10), to: CGPoint(x: view.bounds.width , y: view.bounds.height))
            
            //collision.translatesReferenceBoundsIntoBoundary = true
            theAnimator.addBehavior(collision)
            
            //pushBehavior = UIPushBehavior(items: [squareView!], mode: .continuous)
            //theAnimator.addBehavior(pushBehavior!)
        }
        
        //let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        //view.addGestureRecognizer(tapGestureRecognizer)
    }
    
    /*
    func handleTap(tap : UITapGestureRecognizer)
    {
        /* Get the angle between the center of the square view
         and the tap point */
        
        let tapPoint = tap.location(in: view)
        let squareCenterPoint = self.squareView!.center
        
        /* Calculate the angle between the center point of the square view and
         the tap point to find out the angle of the push
         Formula for detecting the angle between two points is:
         arc tangent 2((p1.x - p2.x), (p1.y - p2.y)) */
        let deltaX = tapPoint.x - squareCenterPoint.x
        let deltaY = tapPoint.y - squareCenterPoint.y
        let angle = atan2(deltaY, deltaX)
        
        pushBehavior!.angle = angle
        
        /* Use the distance between the tap point and the center of our square
         view to calculate the magnitude of the push
         Distance formula is:
         square root of ((p1.x - p2.x)^2 + (p1.y - p2.y)^2) */
        let distanceBetweenPoint = sqrt(pow(deltaX, 2.0) + pow(deltaY, 2.0))
        
        pushBehavior!.magnitude = distanceBetweenPoint / 200.0
        
    }
    */

}


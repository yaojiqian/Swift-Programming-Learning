//
//  ViewController.swift
//  DynamicSnap
//
//  Created by Yao Jiqian on 05/07/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var squareView : UIView?
    var animator : UIDynamicAnimator?
    var snapBehavior : UISnapBehavior?

    func createGestureRecognizer(){
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        view.addGestureRecognizer(tap)
    }

    func createSmallSqareview(){
        squareView = UIView(frame: CGRect(x: 0, y: 0, width: 80, height: 80))
        squareView!.backgroundColor = UIColor.green
        //squareView!.center = view.center
        
        view.addSubview(squareView!)
    }
    
    func createAnimatorAndBehavior(){
        animator = UIDynamicAnimator(referenceView: view)
        
        let collision = UICollisionBehavior(items: [squareView!])
        collision.translatesReferenceBoundsIntoBoundary = true
        
        animator!.addBehavior(collision)

        //let gravityBehavior = UIGravityBehavior(items: [squareView!])
        //animator!.addBehavior(gravityBehavior)
        
        snapBehavior = UISnapBehavior(item: squareView!, snapTo: squareView!.center)
        snapBehavior!.damping = 0.5
        
        animator!.addBehavior(snapBehavior!)
}
    
    func handleTap(tap : UITapGestureRecognizer){
        
        let tapPoint = tap.location(in: view)
        
        if let theSnap = snapBehavior{
            animator!.removeBehavior(theSnap)
        }
        
        snapBehavior = UISnapBehavior(item: squareView!, snapTo: tapPoint)
        snapBehavior!.damping = 0.5
        animator!.addBehavior(snapBehavior!)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        createGestureRecognizer()
        createSmallSqareview()
        createAnimatorAndBehavior()
    }
}


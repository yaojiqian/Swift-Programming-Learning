//
//  ViewController.swift
//  AttachmentBehavior
//
//  Created by Yao Jiqian on 29/06/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var squareView : UIView?
    var squareViewAnchorView : UIView?
    var anchorView : UIView?
    var animator : UIDynamicAnimator?
    var attachmentBehavior : UIAttachmentBehavior?
    
    func createSmallSquareView(){
        squareView = UIView(frame: CGRect(x:0, y:0, width:80, height:80))
        
        if let theSquareView = squareView{
            theSquareView.backgroundColor = UIColor.green
            theSquareView.center = view.center
            
            squareViewAnchorView = UIView(frame: CGRect(x: 60, y: 0, width: 20, height: 20))
            squareViewAnchorView!.backgroundColor = UIColor.brown
            theSquareView.addSubview(squareViewAnchorView!)
            
            view.addSubview(theSquareView)
        }
    }

    func createAnchorView(){
        anchorView = UIView(frame: CGRect(x: 120, y: 120, width: 20, height: 20))
        anchorView!.backgroundColor = UIColor.red
        view.addSubview(anchorView!)
    }
    
    func createGestureRecognizer(){
        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePan))
        view.addGestureRecognizer(panGestureRecognizer)
    }
    
    func createAnimatorAndBehavior(){
        animator = UIDynamicAnimator(referenceView: view)
        
        let collision = UICollisionBehavior(items: [squareView!, anchorView!])
        collision.translatesReferenceBoundsIntoBoundary = true
        
        attachmentBehavior = UIAttachmentBehavior(item: squareView!, offsetFromCenter: UIOffset(horizontal: 30, vertical: -40) , attachedToAnchor: anchorView!.center)
        
        animator!.addBehavior(collision)
        animator!.addBehavior(attachmentBehavior!)
    }
    
    func handlePan(pan : UIPanGestureRecognizer){
        let tapPoint = pan.location(in: view)
        attachmentBehavior!.anchorPoint = tapPoint
        anchorView!.center = tapPoint
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        createGestureRecognizer()
        createSmallSquareView()
        createAnchorView()
        createAnimatorAndBehavior()
    }
    
}


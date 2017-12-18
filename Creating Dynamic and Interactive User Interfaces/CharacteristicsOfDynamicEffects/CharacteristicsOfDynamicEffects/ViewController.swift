//
//  ViewController.swift
//  CharacteristicsOfDynamicEffects
//
//  Created by Yao Jiqian on 05/07/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var animator : UIDynamicAnimator?
    
    func newViewWithCenter(center: CGPoint, backgroundColor : UIColor) -> UIView{
        
        let newView = UIView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        newView.center = center
        newView.backgroundColor = backgroundColor
        
        return newView
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let topView = newViewWithCenter(center: CGPoint(x: 0, y: 0), backgroundColor: UIColor.red)
        let bottomView = newViewWithCenter(center: CGPoint(x : 0, y: 100), backgroundColor: UIColor.green)
        view.addSubview(topView)
        view.addSubview(bottomView)
        
        animator = UIDynamicAnimator(referenceView: view)
        
        let gravityBehavior = UIGravityBehavior(items: [topView, bottomView])
        animator!.addBehavior(gravityBehavior)
        
        let collision = UICollisionBehavior(items: [topView, bottomView])
        collision.translatesReferenceBoundsIntoBoundary = true
        animator!.addBehavior(collision)
        
        let moreElasticItem = UIDynamicItemBehavior(items: [bottomView])
        moreElasticItem.elasticity = 1.0
        moreElasticItem.friction = 0.0
        moreElasticItem.density = 0.5
        
        let lessElasticItem = UIDynamicItemBehavior(items: [topView])
        lessElasticItem.elasticity = 0.5
        lessElasticItem.friction = 1.0
        lessElasticItem.allowsRotation = false
        lessElasticItem.resistance = 10.0
        
        //let moreFriction = UIDynamicItemBehavior(items: [topView])
        //moreFriction.friction = 1.0
        
        
        
        animator!.addBehavior(moreElasticItem)
        animator!.addBehavior(lessElasticItem)
        
        //animator!.addBehavior(moreFriction)
    }
}


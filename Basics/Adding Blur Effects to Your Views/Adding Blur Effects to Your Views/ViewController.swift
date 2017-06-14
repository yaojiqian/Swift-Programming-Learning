//
//  ViewController.swift
//  Adding Blur Effects to Your Views
//
//  Created by Yao Jiqian on 1/15/16.
//  Copyright © 2016 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        let blurEffect = UIBlurEffect(style: .extraLight)
        let vibrancyEffect = UIVibrancyEffect(blurEffect: blurEffect)
        let blurView = UIVisualEffectView(effect: vibrancyEffect)
        blurView.frame.size = CGSize(width: 100, height: 100)
        blurView.center.x = view.center.x + 50
        blurView.center.y = imageView.center.y - 50
        
        let blurEffect2 = UIBlurEffect(style: .light)
        let blurView2 = UIVisualEffectView(effect: blurEffect2)
        blurView2.frame.size = CGSize(width: 100, height: 100)
        blurView2.center.x = view.center.x - 50
        blurView2.center.y = imageView.center.y - 50

        let blurEffect3 = UIBlurEffect(style: .dark)
        let blurView3 = UIVisualEffectView(effect: blurEffect3)
        blurView3.frame.size = CGSize(width: 100, height: 100)
        blurView3.center.x = view.center.x - 50
        blurView3.center.y = imageView.center.y + 50
        
        
        view.addSubview(blurView)
        view.addSubview(blurView2)
        view.addSubview(blurView3)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


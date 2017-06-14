//
//  ViewController.swift
//  Grouping Compact Options with UISegmentedControl
//
//  Created by Yao Jiqian on 5/24/17.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var segmentedControl : UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //let segments = ["iPhone", "iPad", "iPod", "iMac"]
        let segments = [
            "Red",
            UIImage(named: "blueDot")!,
            "Green",
            "Yellow"] as [Any]
        
        segmentedControl = UISegmentedControl(items : segments)
        segmentedControl.center = view.center
        segmentedControl.addTarget(self, action: #selector(segmentedControlValueChanged), for: .valueChanged)
        segmentedControl.isMomentary = false
        
        
        view.addSubview(segmentedControl)
    }

    func segmentedControlValueChanged(sender : UISegmentedControl){
        
        let segmentedControlSelectedIndex = sender.selectedSegmentIndex
        if let segmentedControlSelectedText = sender.titleForSegment(at: segmentedControlSelectedIndex){
            print("selected segment: \(segmentedControlSelectedText)")
        }else{
            print("selected index: \(segmentedControlSelectedIndex)")
        }
    }

}


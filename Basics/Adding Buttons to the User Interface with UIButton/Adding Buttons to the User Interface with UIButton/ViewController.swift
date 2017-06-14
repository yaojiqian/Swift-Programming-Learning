//
//  ViewController.swift
//  Adding Buttons to the User Interface with UIButton
//
//  Created by Yao Jiqian on 5/23/17.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var button : UIButton!
    
    func buttonIsPressed(sender : UIButton){
        print("Button is pressed.")
    }
    
    func buttonIsTapped(sender : UIButton){
        print("Button is Tapped")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let normalImage = UIImage(named:"NormalBlueButton")
        let highlightedImage = UIImage(named:"HighlightedBlueButton")
        
        button = UIButton(type:.system)
        button.frame = CGRect(x: 110, y: 70, width: 100, height: 44)
        button.setTitle("Press Me", for: .normal)
        button.setTitle("I'm Pressed", for: .highlighted)
        
        button.setTitleColor(UIColor.white, for: .normal)
        button.setTitleColor(UIColor.yellow, for: .highlighted)
        
        button.setBackgroundImage(normalImage, for: .normal)
        button.setBackgroundImage(highlightedImage, for: .highlighted)
        
        button.addTarget(self, action: #selector(buttonIsPressed), for: .touchDown)
        button.addTarget(self, action: #selector(buttonIsTapped), for: .touchUpInside)
        
        view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


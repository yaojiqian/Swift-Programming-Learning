//
//  ViewController.swift
//  Creating Using and Customizing Switches with UISwitch
//
//  Created by Yao Jiqian on 5/24/17.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var mainSwitch : UISwitch!
    var button : UIButton!
    
    func changeSwitch(sender:UIButton){
        
        if mainSwitch.isOn{
            mainSwitch.setOn(false, animated: true)
        }else{
            mainSwitch.setOn(true, animated: true)
        }
    }
    
    func switchIsChanged(sender:UISwitch){
        print("Switch is \(sender)")
        
        if sender.isOn{
            print("The value is on")
        }else{
            print("The value is off")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        button = UIButton(type: .system)
        button.frame = CGRect(x:100, y:50, width:100, height: 23)
        button.setTitle("Change Swtch", for: .normal)
        button.addTarget(self, action: #selector(changeSwitch), for: .touchDown)
        
        mainSwitch = UISwitch(frame: CGRect(x:100, y:100, width: 100, height: 100))
        mainSwitch.tintColor = UIColor.red
        mainSwitch.onTintColor = UIColor.blue
        mainSwitch.thumbTintColor = UIColor.green
        
        mainSwitch.addTarget(self, action: #selector(switchIsChanged), for: .valueChanged)
        
        view.addSubview(button)
        view.addSubview(mainSwitch)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


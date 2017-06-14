//
//  ViewController.swift
//  Picking Values with the UIPickerView
//
//  Created by Yao Jiqian on 5/24/17.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource, UIPickerViewDelegate
{
    
    var picker : UIPickerView!
    var button : UIButton!
    var pickerArray : Array = ["one", "two", "three", "four", "five", "six", "seven", "eight", "nine", "ten"]

    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker = UIPickerView()
        picker.dataSource = self
        picker.center = view.center
        picker.delegate = self
        
        button = UIButton(type:.system)
        button.frame = CGRect(x:100, y: 50, width: 100, height: 23)
        button.setTitle("set pick", for: .normal)
        button.addTarget(self, action: #selector(setPickerValue), for: .touchDown)
        
        view.addSubview(picker)
        view.addSubview(button)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setPickerValue(sender : UIButton){
        picker.selectRow(2, inComponent: 0, animated: true)
        
    }

    func numberOfComponents(in pickerView : UIPickerView) -> Int{
        if pickerView == picker{
            return 1
        }else{
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int{
        
        if pickerView == picker{
            return 10
        }else{
            return 0
        }
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int,
                    forComponent component: Int) -> String?{
        return pickerArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if pickerView == picker{
            print("selected row:\(row), value:\(pickerArray[row])")
        }
    }
    
}

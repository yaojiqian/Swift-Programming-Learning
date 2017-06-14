//
//  ViewController.swift
//  Picking the Date and Time with UIDatePicker
//
//  Created by Yao Jiqian on 5/24/17.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var datePicker : UIDatePicker!
    var slider : UISlider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        datePicker = UIDatePicker()
        datePicker.center = view.center
        datePicker.datePickerMode = .dateAndTime
        datePicker.locale = Locale(identifier: "zh")
        datePicker.timeZone = TimeZone(identifier: "China/Beijing")
        
        datePicker.addTarget(self, action: #selector(datePickerChanged(sender:)), for: .valueChanged)
        
        slider = UISlider(frame: CGRect(x:100, y: 50, width: 200, height: 30))
        slider.minimumValue = 0
        slider.maximumValue = 100
        slider.value = 32
        slider.addTarget(self, action: #selector(sliderValueChanged), for: .valueChanged)
        
        
        view.addSubview(slider)
        view.addSubview(datePicker)
    }

    func sliderValueChanged(sender : UISlider){
        print("slider value : \(slider.value)")
    }

    func datePickerChanged(sender : UIDatePicker){
        let lo = Locale.autoupdatingCurrent
        print("selected date: \(datePicker.date.description(with: lo))")
    }

}

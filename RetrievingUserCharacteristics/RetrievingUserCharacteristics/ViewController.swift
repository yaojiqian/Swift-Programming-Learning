//
//  ViewController.swift
//  RetrievingUserCharacteristics
//
//  Created by Yao Jiqian on 20/06/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController {
    
    let dateOfBirthCharacteristicsType = HKCharacteristicType.characteristicType(forIdentifier: .dateOfBirth)
    
    lazy var types : Set<HKCharacteristicType> = {
       return [self.dateOfBirthCharacteristicsType!]
    }()
    
    lazy var healthStore = HKHealthStore()
    
    var birthDayLabel : UILabel = UILabel()
    var ageLabel : UILabel = UILabel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        birthDayLabel.frame = CGRect(x: 100, y:100, width: 200, height: 50)
        self.view.addSubview(birthDayLabel)
        
        ageLabel.frame = CGRect(x:100, y:150, width: 200, height: 50)
        self.view.addSubview(ageLabel)
    }

    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if HKHealthStore.isHealthDataAvailable() {
            
            healthStore.requestAuthorization(toShare: nil, read: types, completion: {[weak self] (success: Bool, error: Error?) in
                
                let strongSelf = self!
                if success && error == nil{
                    DispatchQueue.main.async (execute: strongSelf.readDateOfBirthInformation)
                } else {
                    if let theError = error {
                        print("request authorization fail, \(theError)")
                    }
                }
            })
            
        } else {
            print ("Health Data is not available.")
        }
    }

    func readDateOfBirthInformation(){
        
        //var dateOfBirthError : Error?
        do{
            let dateOfBirth = try healthStore.dateOfBirthComponents()
            print("dateOfBirth: \(dateOfBirth)")
            //let calendar = Calendar(identifier: .chinese)
            //print("calendar: \(calendar)")
            let date = dateOfBirth.date!
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .medium
            dateFormatter.locale = Locale(identifier: "zh-CN")
            print("birthday: \(dateFormatter.string(from: date))")
            
            birthDayLabel.text = dateFormatter.string(from: date)
            
            let now = Date()
            let currentDateComponents = Calendar.current.dateComponents([.year], from: date, to: now)
            if let age = currentDateComponents.year {
                let numberFormatter = NumberFormatter()
                numberFormatter.locale = Locale(identifier: "zh_CN")
                let ageString = numberFormatter.string(from :NSNumber(value: age))!
                print("age: \(ageString)")
                ageLabel.text = ageString
            }
            
            
        } catch _{
            print("Erro occured!")
        }
    }
    
}


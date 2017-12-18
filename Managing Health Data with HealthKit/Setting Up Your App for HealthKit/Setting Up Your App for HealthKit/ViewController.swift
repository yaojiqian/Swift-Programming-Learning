//
//  ViewController.swift
//  Setting Up Your App for HealthKit
//
//  Created by Yao Jiqian on 12/06/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//


import UIKit
import HealthKit

class ViewController: UIViewController {
    
    let heightQuantity = HKQuantityType.quantityType(
        forIdentifier: HKQuantityTypeIdentifier.height)!
    
    let weightQuantity = HKQuantityType.quantityType(
        forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
    
    let heartRateQuantity = HKQuantityType.quantityType(
        forIdentifier: HKQuantityTypeIdentifier.heartRate)!
    
    lazy var healthStore = HKHealthStore()
    
    /* The type of data that we wouldn't write into the health store */
    lazy var typesToShare: Set<HKSampleType> = {
        return [self.heightQuantity, self.weightQuantity]
    }()
    
    /* We want to read this type of data */
    lazy var typesToRead: Set<HKObjectType> = {
        return [self.heightQuantity, self.weightQuantity, self.heartRateQuantity]
    }()
    
    /* Ask for permission to access the health store */
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if HKHealthStore.isHealthDataAvailable(){
            
            healthStore.requestAuthorization(toShare: typesToShare,read: typesToRead,completion: {succeeded, error in
                    if succeeded && error == nil{
                        print("Successfully received authorization")
                    } else {
                        if let theError = error{
                            print("Error occurred = \(theError)")
                        }
                }
            })
            
        } else {
            print("Health data is not available")
        }
        
    }
    
}

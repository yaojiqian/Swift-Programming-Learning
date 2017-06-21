//
//  ViewController.swift
//  ObservingHealthInformation
//
//  Created by Yao Jiqian on 21/06/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController {
    
    let weightQuantityType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
    
    lazy var types : Set<HKQuantityType> = {
        return [self.weightQuantityType]
    }()
    
    lazy var healthStore = HKHealthStore()
    
    lazy var predicate : NSPredicate = {
        let now = Date()
        let yesterDay = Calendar.current.date(byAdding: Calendar.Component.day, value: -1, to: now)
        
        return HKQuery.predicateForSamples(withStart: yesterDay, end: now, options: .strictEndDate)
    }()
    
    lazy var query : HKObserverQuery = {[weak self] in
        let strongSelf = self!
        return HKObserverQuery(sampleType: strongSelf.weightQuantityType, predicate: strongSelf.predicate, updateHandler: strongSelf.weightChangedHandler)
    }()

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if HKHealthStore.isHealthDataAvailable() {
            healthStore.requestAuthorization(toShare: nil, read: types, completion: { [weak self](succeeded : Bool, error : Error?) in
                if succeeded {
                    let strongSelf = self!
                    DispatchQueue.main.async(
                        execute: strongSelf.startObserveringWeightChanges
                    )
                } else {
                    if let theError = error{
                        print("\(theError)")
                    }
                }
            })
            
        } else {
            print("Health data is not available.")
        }
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        stopObserveringWeightChanges()
    }
    

    func startObserveringWeightChanges(){
        healthStore.execute(query)
        healthStore.enableBackgroundDelivery(for: weightQuantityType, frequency: .immediate) { (successed : Bool, error :Error?) in
            if successed {
                print("Enabled background delivery of weight changes")
            } else {
                if let theError = error{
                    print("Failed to enable background delivery of weight changes. ")
                    print("Error = \(theError)")
                }
            }
        }
    }
    
    func stopObserveringWeightChanges(){
        healthStore.stop(query)
        healthStore.disableAllBackgroundDelivery { (succeeded : Bool, error : Error?) in
            if succeeded{
                print("Disabled background delivery of weight changes")
            }else{
                if let theError = error{
                    print("Failed to disable background delivery of weight changes. ")
                    print("Error = \(theError)")
                }
            }
        }
    }
    
    func fetchRecordedWeightsInLastDay(){
        print("in fetchRecordedWeightsInLastDay")
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: true)
        let query = HKSampleQuery(sampleType: weightQuantityType, predicate: predicate, limit:HKObjectQueryNoLimit, sortDescriptors: [sortDescriptor]) { /*[weak self]*/(query : HKSampleQuery, results : [HKSample]?, error : Error?) in
            
            if results!.count > 0 {
                for sample in results as! [HKQuantitySample] {
                    /* Get the weight in kilograms from the quantity */
                    let weightInKilograms = sample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
                    
                    /* This is the value of "KG", localized in user's language */
                    let formatter = MassFormatter()
                    let kilogramSuffix = formatter.unitString(fromValue: weightInKilograms, unit: .kilogram)
                    
                    DispatchQueue.main.async {/*[weak self] in*/
                        //let strongSelf = self!
                        
                        print("Weight has been changed to " +
                            "\(weightInKilograms) \(kilogramSuffix)")
                        let dateFormatter = DateFormatter()
                        dateFormatter.locale = Locale(identifier: "zh-CN")
                        dateFormatter.dateStyle = .long
                        dateFormatter.timeStyle = .medium
                        print("Change date = \(dateFormatter.string(from :sample.startDate))")
                    }
                }
            }else{
                print("Could not read the user's weight ")
                print("or no weight data was available")
            }
        }
        healthStore.execute(query)
    }
    
    func weightChangedHandler(query: HKObserverQuery, complicationHandler: HKObserverQueryCompletionHandler, error : Error?){
        
        /* Be careful, we are not on the UI thread */
        fetchRecordedWeightsInLastDay()
        
        complicationHandler()
    }
}


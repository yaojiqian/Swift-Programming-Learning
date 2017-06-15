//
//  ViewController.swift
//  Retrieving and Modifying the User’s Weight Information
//
//  Created by Yao Jiqian on 14/06/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    /* This is a label that shows the user's weight unit (Kilograms) on the righthand side of our text field */
    let textFieldRightLabel = UILabel(frame: CGRect.zero)
    
    let weightQuantityType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
    
    lazy var types : Set<HKQuantityType> = {
        return [self.weightQuantityType]
    }()
    
    lazy var healthStore = HKHealthStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.rightView = textFieldRightLabel
        textField.rightViewMode = .always
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        if HKHealthStore.isHealthDataAvailable() {
            
            healthStore.requestAuthorization(toShare: types,
                read: types,
                completion: {[weak self]
                (successed : Bool, error : Error?) in
                
                let strongSelf = self!
                if successed && error == nil{
                    DispatchQueue.main.async(execute: strongSelf.readWeightInformation)
                } else {
                    if let theError = error{
                        print("Error occurred = \(theError)")
                    }
                }
            })
        } else {
            print("Health data is not available")
            saveButton.isEnabled = false
        }
    }
    
    
    @IBAction func saveUserWeight(_ sender: UIButton) {
        
        let kilogramUnit = HKUnit.gramUnit(with: .kilo)
        let weightQuantity = HKQuantity(unit: kilogramUnit, doubleValue: (textField.text! as NSString).doubleValue)
        let now = Date()
        let sample = HKQuantitySample(type: weightQuantityType, quantity: weightQuantity, start: now, end: now)
        
        healthStore.save(sample, withCompletion:{ (success : Bool, error: Error?) in
            if success && error == nil{
                print("Successfully saved the user's weight")
            } else {
                print("Failed to save the user's weight")
            }
        } )
    }
    
    func readWeightInformation(){
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: weightQuantityType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor], resultsHandler: {[weak self]
            (query: HKSampleQuery, results:[HKSample]?, error : Error?) in
            
            if (results?.count)! > 0 {
                /* We really have only one sample */
                let sample = results?[0] as! HKQuantitySample
                /* Get the weight in kilograms from the quantity */
                let weightInKilogram = sample.quantity.doubleValue(for: HKUnit.gramUnit(with: .kilo))
                
                /* This is the value of KG, localized in user's language */
                let formatter = MassFormatter()
                let kilogramSuffix = formatter.unitString(fromValue: weightInKilogram, unit: .kilogram)
                
                DispatchQueue.main.async{
                    
                    let strongSelf = self!
                    
                    /* Set the value of KG on the righthand side of the text field */
                    strongSelf.textFieldRightLabel.text = kilogramSuffix
                    strongSelf.textFieldRightLabel.sizeToFit()
                    
                    /* And finally set the text field's value to the user's weight */
                    let weightFormattedString = NumberFormatter.localizedString(from: NSNumber(value : weightInKilogram), number: NumberFormatter.Style.none)
                    
                    strongSelf.textField.text = weightFormattedString
                }
            } else {
                print("Could not read the user's weight ")
                print("or no weight data was available")
            }
        })
        
        healthStore.execute(query)
    }

}


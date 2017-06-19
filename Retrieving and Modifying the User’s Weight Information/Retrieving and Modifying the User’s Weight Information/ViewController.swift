//
//  ViewController.swift
//  Retrieving and Modifying the User’s Weight Information
//
//  Created by Yao Jiqian on 14/06/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit
import HealthKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    enum HeightUnits : String {
        case Millimeters = "Millimeters"
        case Centimeters = "Centimeters"
        case Meters = "Meters"
        case Inches = "Inches"
        case Feet = "Feet"
        
        static let allValues = [Millimeters, Centimeters, Meters, Inches, Feet]
        
        func healthKitUnit() -> HKUnit{
            switch self{
            case .Millimeters:
                return HKUnit.meterUnit(with: .milli)
            case .Centimeters:
                return HKUnit.meterUnit(with: .centi)
            case .Meters:
                return HKUnit.meter()
            case .Inches:
                return HKUnit.inch()
            case .Feet:
                return HKUnit.foot()
            }
        }
        
        func heightAbbreviation() -> String{
            switch self{
            case .Millimeters:
                return "mm"
            case .Centimeters:
                return "cm"
            case .Meters:
                return "m"
            case .Feet:
                return "ft"
            case .Inches:
                return "in"
            }
        }
    }
    
    struct TableViewInfo{
        static let cellIdentifier = "Cell"
    }

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var heightTextField: UITextField!
   
    /* This is a label that shows the user's weight unit (Kilograms) on the righthand side of our text field */
    let textFieldRightLabel = UILabel(frame: CGRect.zero)
    
    let heightRightLabel = UILabel(frame: CGRect.zero)
    
    let weightQuantityType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.bodyMass)!
    
    lazy var types : Set<HKQuantityType> = {
        return [self.weightQuantityType, self.heightQuantityType]
    }()
    
    
    /* The currently selected height unit */
    var heightUnit : HeightUnits = .Millimeters{
        willSet{
            readHeightInformation()
        }
    }
    
    /* Keep track of which index path is tapped so that we can put a checkmark next to it */
    var selectedPath = IndexPath(row: 0, section: 0)
    
    let heightQuantityType = HKQuantityType.quantityType(forIdentifier: HKQuantityTypeIdentifier.height)!
    
    lazy var healthStore = HKHealthStore()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.rightView = textFieldRightLabel
        textField.rightViewMode = .always
        
        heightTextField.rightView = heightRightLabel
        heightTextField.rightViewMode = .always
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: TableViewInfo.cellIdentifier)
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
                    DispatchQueue.main.async(execute: strongSelf.readHeightInformation)
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
    
    @IBAction func saveUserHeight(_ sender: UIButton) {
        
        let heightKitUnit = self.heightUnit.healthKitUnit()
        let heightQuantity = HKQuantity(unit: heightKitUnit, doubleValue: (heightTextField.text! as NSString).doubleValue)
        let now = Date()
        let sample = HKQuantitySample(type:heightQuantityType, quantity: heightQuantity, start: now, end: now)
        
        healthStore.save(sample, withCompletion:  { (success : Bool, error :Error?) in
            if success {
                print("Successfully saved the user's height.")
            } else {
                print("Failed to save the user's height.")
            }
        })
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
    
    func readHeightInformation(){
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)
        
        let query = HKSampleQuery(sampleType: heightQuantityType, predicate: nil, limit: 1, sortDescriptors: [sortDescriptor], resultsHandler: {[weak self]
            (query: HKSampleQuery, results : [HKSample]?, error : Error?) in
            
            let strongSelf = self!
            if(results?.count)! > 0 {
                /* We really have only one sample */
                let sample = results?[0] as! HKQuantitySample
                /* Get the height in currently selected unit */
                let currentSelectedUnit = strongSelf.heightUnit.healthKitUnit()
                
                
                let heightInUnit = sample.quantity.doubleValue(for: currentSelectedUnit)
                DispatchQueue.main.async {
                    /* And finally set the text field's value to the user's height */
                    let heightFormattedAsString = NumberFormatter.localizedString(from: NSNumber(value : heightInUnit), number: .decimal)
                    
                    strongSelf.heightTextField.text = heightFormattedAsString
                    strongSelf.heightRightLabel.text = strongSelf.heightUnit.heightAbbreviation()
                    strongSelf.heightRightLabel.sizeToFit()
                }
            } else {
                print("Could not read the user's height ")
                print("or no height data was available")
            }
        })
        healthStore.execute(query)
    }
    
    /* Functions for TableView */
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return HeightUnits.allValues.count
    }
    
    /* If a new cell is selected, show the selection only for that cell and remove the selection from the previously-selected cell */
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let previouslySelectedIndexPath = selectedPath
        selectedPath = indexPath
        
        tableView.reloadRows(at: [previouslySelectedIndexPath , selectedPath], with: .automatic)
        
        self.heightUnit = HeightUnits.allValues[selectedPath.row]
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewInfo.cellIdentifier, for: indexPath) as UITableViewCell
        
        let heightUnit = HeightUnits.allValues[indexPath.row]
        cell.textLabel?.text = heightUnit.rawValue
        
        if indexPath == selectedPath{
            cell.accessoryType = .checkmark
        }else {
            cell.accessoryType = .none
        }
        
        return cell
    }
}


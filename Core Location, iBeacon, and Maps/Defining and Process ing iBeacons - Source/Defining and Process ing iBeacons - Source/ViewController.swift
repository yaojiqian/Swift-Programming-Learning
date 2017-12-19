//
//  ViewController.swift
//  Defining and Process ing iBeacons - Source
//
//  Created by Yao Jiqian on 19/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit
import CoreLocation
import CoreBluetooth

class ViewController: UIViewController, CBPeripheralManagerDelegate {
    
    var peripheralManager : CBPeripheralManager?
    
    /* A newly-generated UUID for our beacon */
    let uuid = UUID()
    
    /* The identifier of our beacon is the identifier of our bundle here */
    let identifier = Bundle.main.bundleIdentifier!
    
    /* Made up major and minor versions of our beacon region */
    let major : CLBeaconMajorValue = 1
    let minor : CLBeaconMinorValue = 0
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let queue = DispatchQueue.global(qos: .default)
        peripheralManager = CBPeripheralManager(delegate : self, queue : queue)
        if let manager = peripheralManager {
            manager.delegate = self
        }
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        
        peripheral.stopAdvertising()
        
        print("The peripheral state is ")
        switch peripheral.state {
        case .poweredOn:
            print("Powered On")
        case .poweredOff:
            print("Powered Off")
        case .resetting:
            print("Resetting")
        case .unauthorized:
            print("Unauthorized")
        case .unknown:
            print("Unknown")
        case .unsupported:
            print("Unsupported")
        }
        
        /* Make sure Bluetooth is powered on */
        if peripheral.state != .poweredOn {
            let alertController = UIAlertController(title: "Bluetooth", message: "Please turn Bluetooth On", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }else{
            //let region = CLBeaconRegion(proximityUUID: uuid, major: major, minor: minor, identifier: identifier)
            let manufacturerData = identifier.data(using: String.Encoding.utf8)
            let theUuid = CBUUID(nsuuid: uuid)
            let dataToBeAdvertised:[String: Any] = [
                CBAdvertisementDataLocalNameKey : "Sample peripheral",
                CBAdvertisementDataManufacturerDataKey : manufacturerData as Any,
                CBAdvertisementDataServiceUUIDsKey : [theUuid]
            ]
            peripheral.startAdvertising(dataToBeAdvertised)
        }
    }
    
    func peripheralManagerDidStartAdvertising(_ peripheral: CBPeripheralManager, error: Error?) {
        if error == nil{
            print("Successfully started advertising our beacon data")

            let message = "Successfully set up your beacon. " + "The unique identifier of our service is: \(uuid.uuidString)"

            let controller = UIAlertController(title: "iBeacon", message: message, preferredStyle: .alert)
            controller.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(controller, animated: true, completion: nil)
        }else{
            print("Failed to advertise our beacon. Error = \(error)")
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


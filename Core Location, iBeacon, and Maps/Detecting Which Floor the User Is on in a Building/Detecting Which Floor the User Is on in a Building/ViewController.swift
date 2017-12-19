//
//  ViewController.swift
//  Detecting Which Floor the User Is on in a Building
//
//  Created by Yao Jiqian on 19/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController , CLLocationManagerDelegate{

    var manager : CLLocationManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        manager = CLLocationManager()
        manager.delegate = self
        //manager.requestAlwaysAuthorization()
        manager.desiredAccuracy = kCLLocationAccuracyBest
        manager.startUpdatingLocation()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        
        print("Updated locations... \(#function)")
        if locations.count > 0{
            let location = (locations as [CLLocation])[0]
            print("Location found = \(location)")
            if let theFloor = location.floor{
                print("The floor information is = \(theFloor)")
            }else{
                print("No floor information is available")
            }
        }
    }

}


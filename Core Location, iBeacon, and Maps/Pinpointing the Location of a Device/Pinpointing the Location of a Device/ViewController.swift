//
//  ViewController.swift
//  Pinpointing the Location of a Device
//
//  Created by Yao Jiqian on 20/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit

class ViewController: UIViewController , CLLocationManagerDelegate {
    
    var locationManager : CLLocationManager!
    
    func displayAlertWithTitle(title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    func createLocationManager(startImmediately: Bool){
        locationManager = CLLocationManager()
        if let manager = locationManager {
            print("Successfully created the location manager")
            manager.delegate = self
            if startImmediately {
                manager.startUpdatingHeading()
            }
        }
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /* Are location services available on this device? */
        if CLLocationManager.locationServicesEnabled() {
            
            /* Do we have authorization to access location services? */
            switch CLLocationManager.authorizationStatus() {
            case .authorizedAlways:
                /* Yes, always. */
                createLocationManager(startImmediately: true)
            case .authorizedWhenInUse:
                /* Yes, only when our app is in use. */
                createLocationManager(startImmediately: true)
            case .denied:
                /* No. */
                displayAlertWithTitle(title: "Not Determined", message: "Location services are not allowed for this app")
            case .notDetermined:
                /* We don't know yet; we have to ask */
                createLocationManager(startImmediately: false)
                if let manager = locationManager {
                    manager.requestWhenInUseAuthorization()
                }
            case .restricted:
                /* Restrictions have been applied; we have no access to location services. */
                displayAlertWithTitle(title: "Restricted",  message: "Location services are not allowed for this app")
            }
        }else{
            /* Location services are not enabled. Take appropriate action: for instance, prompt the user to enable the location services. */
            print("Location services are not enabled")
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


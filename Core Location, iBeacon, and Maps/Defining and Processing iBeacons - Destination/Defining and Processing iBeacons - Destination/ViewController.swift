//
//  ViewController.swift
//  Defining and Processing iBeacons - Destination
//
//  Created by Yao Jiqian on 20/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit
import CoreBluetooth
import CoreLocation

class ViewController: UIViewController , CLLocationManagerDelegate{
    
    var locationManager : CLLocationManager!
    
    /* Place your beacon UUID here. This is the UUID of the source
     application that we have already written. I ran that app
     on a device and copied and pasted the UUID here in the destination application */
    let uuid = UUID(uuidString: "1FBF369D-6E55-4F3C-A4DA-CDE6155920A1")
    /* This is the identifier of the beacon that we just wrote. The identifier of the beacon was chosen to be the same as the bundle id of
     that app. */
    let identifier = "com.BigBit.Defining-and-Processing-iBeacons---Source"
    
    required init?(coder aDecoder: NSCoder) {
        locationManager = CLLocationManager()
        super.init(coder: aDecoder)
        locationManager.delegate = self
    }
    
    /* We will know when we have made contact with a beacon here */
    func locationManager(_ manager: CLLocationManager, didRangeBeacons beacons: [CLBeacon], in region: CLBeaconRegion) {
        
        print("Found a beacon with the proximity of = ")
        
        /* How close are we to the beacon? */
        for beacon in beacons {
            switch beacon.proximity {
            case .far:
                print("Far")
            case .immediate:
                print("Immediate")
            case .near:
                print("Near")
            default:
                print("Unknown")
            }
        }
    }
    
    /* This lets us know when we are exiting the region of the beacon */
    func locationManager(_ manager: CLLocationManager, didExitRegion region: CLRegion) {
        print("You are exiting the region of a beacon " +
            "with an identifier of \(region.identifier)")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let region = CLBeaconRegion(proximityUUID: uuid!, identifier: identifier)
        locationManager.startRangingBeacons(in: region)
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


//
//  ViewController.swift
//  Customizing the View of the Map with a Camera
//
//  Created by Yao Jiqian on 21/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate , CLLocationManagerDelegate{
    
    var mapView : MKMapView!
    let locationManager = CLLocationManager()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        mapView = MKMapView()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapType = .standard
        mapView.frame = view.frame
        mapView.delegate = self
        view.addSubview(mapView)
        
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.showsUserLocation = true

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }

    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        print("Setting the camera for our map view...")
        
        let userCoordinate = userLocation.coordinate
        /* Assuming my location is hardcoded to lat: 39.795896 and long:116.50887, the following camera angle works perfectly for me */
        let eyeCoordinate = CLLocationCoordinate2D(latitude: 39.775896, longitude: 116.55887)
        let camera = MKMapCamera(lookingAtCenter: userCoordinate, fromEyeCoordinate: eyeCoordinate, eyeAltitude: 400.0)
        
        mapView.setCamera(camera, animated: true)
    }

}


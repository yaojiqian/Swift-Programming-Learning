//
//  ViewController.swift
//  Searching on a Map View
//
//  Created by Yao Jiqian on 21/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController, MKMapViewDelegate , CLLocationManagerDelegate{
    
    var mapView: MKMapView!
    var locationManager: CLLocationManager!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        mapView = MKMapView()
    }

    /* Set up the map and add it to our view */
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapType = .standard
        mapView.frame = view.frame
        mapView.delegate = self
        view.addSubview(mapView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /* The authorization status of the user has changed; we need to react to that so that if she has authorized our app to to view her location, we will accordingly attempt to do so */
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        switch CLLocationManager.authorizationStatus() {
        case .denied:
            print("Denied")
        case .restricted:
            print("Restricted")
        case .notDetermined:
            print("Not Determined")
        default:
            showUserLocationOnTheMap()
        }
    }
    
    /* Just a little method to help us display alert dialogs to the user */
    func displayAlertWithTitle(_ title: String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
    
    /* We call this method when we are sure that the user has given us access to her location */
    func showUserLocationOnTheMap(){
        mapView.showsUserLocation = true
        mapView.userTrackingMode = .follow
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /* Are location services available on this device? */
        if CLLocationManager.locationServicesEnabled() {
            /* Do we have authorization to access location services? */
            switch CLLocationManager.authorizationStatus() {
            case .denied:
                /* No */
                displayAlertWithTitle("Not Determind", message: "Location Service is not allowed for this app.")
            case .restricted:
                /* Restrictions have been applied; we have no access to location services */
                displayAlertWithTitle("Restricted", message: "Location services are not allowed for this app")
            case .notDetermined:
                /* We don't know yet; we have to ask */
                locationManager = CLLocationManager()
                if let manager = locationManager {
                    manager.requestWhenInUseAuthorization()
                }
            default:
                showUserLocationOnTheMap()
            }
        }else{
            /* Location services are not enabled. Take appropriate action: for instance, prompt the user to enable the location services. */
            print("Location services are not enabled")
        }
    }
    
    func mapView(_ mapView: MKMapView, didFailToLocateUserWithError error: Error) {
        displayAlertWithTitle("Failed", message: "Could not get user's location.")
    }
    
    func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
        
        let request = MKLocalSearchRequest()
        request.naturalLanguageQuery = "restaurant"
        
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        request.region = MKCoordinateRegion(center: (userLocation.location?.coordinate)!, span: span)
        
        let search = MKLocalSearch(request: request)
        search.start(completionHandler: {
            (response: MKLocalSearchResponse?, error: Error?) in
            for item in (response?.mapItems)! {
                print("item name = \(item.name ?? " ")")
                print("Item phone number = \(item.phoneNumber ?? " ")")
                print("Item url = \(String(describing: item.url))")
                print("Item location = \(String(describing: item.placemark.location))")
            }
        } )
    }
}


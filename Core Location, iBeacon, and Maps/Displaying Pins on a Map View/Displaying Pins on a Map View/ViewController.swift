//
//  ViewController.swift
//  Displaying Pins on a Map View
//
//  Created by Yao Jiqian on 20/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController , MKMapViewDelegate{
    
    var mapView : MKMapView!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        mapView = MKMapView()
    }

    /* We have a pin on the map; now zoom into it and make that pin the center of the map */
    func setCenterOfMapToLaction(_ location : CLLocationCoordinate2D){
        let span = MKCoordinateSpan(latitudeDelta: 0.01, longitudeDelta: 0.01)
        let region = MKCoordinateRegion(center: location, span: span)
        mapView.setRegion(region, animated: true)
    }
    
    func addPinToMapView(){
        /* This is just a sample location */
        let location = CLLocationCoordinate2D(latitude: 39.592737, longitude: 116.185898)
        
        /* Create the annotation using the location */
        let annotation = MyAnnotation(coordinate: location, title: "My Title", subtitle: "My SubTitle")
        
        /* And eventually add it to the map */
        mapView.addAnnotation(annotation)
        
        /* And now center the map around the point */
        setCenterOfMapToLaction(location)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapType = .standard
        mapView.frame = view.frame
        view.addSubview(mapView)
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        addPinToMapView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


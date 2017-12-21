//
//  ViewController.swift
//  Displaying Custom Pins on a Map View
//
//  Created by Yao Jiqian on 20/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit
import MapKit

class ViewController: UIViewController, MKMapViewDelegate {

    var mapView: MKMapView!
    
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
        /* These are just sample locations */
        let purpleLocation = CLLocationCoordinate2D(latitude: 31.218420, longitude: 121.496459)
        
        let blueLocation = CLLocationCoordinate2D(latitude: 31.218310, longitude: 121.496554)
        
        let redLocation = CLLocationCoordinate2D(latitude: 31.218513, longitude: 121.496364)
        
        let greenLocation = CLLocationCoordinate2D(latitude: 31.218416, longitude: 121.496650)
        
        /* Create the annotations using the location */
        let purpleAnnotation = MyAnnotation(coordinate: purpleLocation, title: "Purple", subtitle: "PIN", pinColor: .Purple)
        let blueAnnotation = MyAnnotation(coordinate: blueLocation, title: "Blue", subtitle: "Pin")
        let redAnnotation = MyAnnotation(coordinate: redLocation, title: "Red", subtitle: "Pin", pinColor: .Red)
        let greenAnnotation = MyAnnotation(coordinate: greenLocation, title: "Green", subtitle: "Pin", pinColor: .Green)
        
        /* And eventually add them to the map */
        mapView.addAnnotations([purpleAnnotation, blueAnnotation, redAnnotation, greenAnnotation])
        //mapView.addAnnotations([blueAnnotation])
        
        /* And now center the map around the point */
        setCenterOfMapToLaction(blueLocation)
    }
    
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView?{
        if annotation is MyAnnotation == false{
            return nil
        }
        
        /* First, typecast the annotation for which the Map View fired this delegate message */
        let senderAnnotation = annotation as! MyAnnotation
        
        /* We will attempt to get a reusable identifier for the pin we are about to create */
        let pinReusableIdentifier = senderAnnotation.pinColor?.rawValue
        
        /* Using the identifier we retrieved above, we will attempt to reuse a pin in the sender Map View */
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: pinReusableIdentifier!) as? MKPinAnnotationView
        
        if annotationView == nil{
            /* If we fail to reuse a pin, we will create one */
            annotationView = MKPinAnnotationView(annotation: senderAnnotation, reuseIdentifier: pinReusableIdentifier)
            
            /* Make sure we can see the callouts on top of each pin in case we have assigned title and/or subtitle to each pin */
            annotationView?.canShowCallout = true
        }
        
        if senderAnnotation.pinColor == .Blue{
            let pinImage = UIImage(named: "BluePin")
            let blueAnnotationView = MKAnnotationView(annotation: senderAnnotation, reuseIdentifier: pinReusableIdentifier)
            blueAnnotationView.canShowCallout = true
            blueAnnotationView.image = pinImage
            return blueAnnotationView
        }else{
            annotationView!.pinTintColor = senderAnnotation.pinColor?.toPinColor()
        }
        
        return annotationView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.mapType = .standard
        mapView.frame = view.frame
        mapView.delegate = self
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


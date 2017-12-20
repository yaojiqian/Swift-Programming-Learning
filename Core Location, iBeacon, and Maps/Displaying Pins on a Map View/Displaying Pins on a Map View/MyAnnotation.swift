//
//  MyAnnotation.swift
//  Displaying Pins on a Map View
//
//  Created by Yao Jiqian on 20/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit
import MapKit

class MyAnnotation : NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0, 0)
    var title: String?
    var subtitle: String?
    
    init(coordinate : CLLocationCoordinate2D, title : String, subtitle : String){
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        super.init()
    }
}

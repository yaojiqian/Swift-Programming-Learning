//
//  MyAnnotation.swift
//  Displaying Custom Pins on a Map View
//
//  Created by Yao Jiqian on 20/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit
import MapKit

/* This allows us to check for equality between two items of type PinColor */
func ==(left: PinColor, right: PinColor)->Bool{
    return left.rawValue == right.rawValue
}

/* The various pin colors that our annotation can have */
enum PinColor: String{
    case Blue = "Blue"
    case Red = "Red"
    case Green = "Green"
    case Purple = "Purple"
    
    /* We convert our pin color to the system pin color */
    func toPinColor()->UIColor{
        switch self{
        case .Red:
            return UIColor.red
        case .Green:
            return UIColor.green
        case .Purple:
            return UIColor.purple
        default:
            /* For the blue pin, this returns .Red but we need to return *a* value in this function. For this case, we ignore the return value */
            return UIColor.red
        }
    }
}

class MyAnnotation : NSObject, MKAnnotation{
    var coordinate: CLLocationCoordinate2D = CLLocationCoordinate2DMake(0,0)
    var title: String?
    var subtitle: String?
    var pinColor: PinColor?
    
    init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String, pinColor: PinColor){
        self.coordinate = coordinate
        self.title = title
        self.subtitle = subtitle
        self.pinColor = pinColor
        super.init()
    }
    
    convenience init(coordinate: CLLocationCoordinate2D, title: String, subtitle: String){
        self.init(coordinate: coordinate, title: title, subtitle: subtitle, pinColor: .Blue)
    }
}

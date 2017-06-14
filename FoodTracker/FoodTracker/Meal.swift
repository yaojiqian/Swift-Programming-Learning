//
//  Meal.swift
//  FoodTracker
//
//  Created by 姚骥迁 on 11/25/15.
//  Copyright © 2015 BigBit Corp. All rights reserved.
//

import UIKit

class Meal : NSObject, NSCoding{
    
    // MARK: Properties
    struct PropertyKey{
        static let nameKey = "name"
        static let photoKey = "photo"
        static let ratingKey = "rating"
    }
    
    var name: String
    var photo: UIImage?
    var rating: Int
    
    //MARK: Archiving Path
    static let DocumentsDirectory = NSFileManager().URLsForDirectory(.DocumentDirectory , inDomains: .UserDomainMask).first!
    static let ArchiveURL = DocumentsDirectory.URLByAppendingPathComponent("meals")
    
    //MARK: Initialization
    init?(name: String, photo: UIImage?, rating: Int){
        // Initialize stored properties.
        self.name = name
        self.photo = photo
        self.rating = rating
        
        super.init()
        
        // Initialization should fail if there is no name or if the rating is negative.
        if name.isEmpty || rating < 0{
            return nil
        }
    }
    
    //MARK: NSCoding
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(name, forKey: PropertyKey.nameKey)
        aCoder.encodeObject(photo, forKey: PropertyKey.photoKey)
        aCoder.encodeObject(rating, forKey: PropertyKey.ratingKey)
    }
    
    required convenience init?(coder aDecoder: NSCoder){
        let name = aDecoder.decodeObjectForKey(PropertyKey.nameKey) as! String
        let photo = aDecoder.decodeObjectForKey(PropertyKey.photoKey) as? UIImage
        let rating = aDecoder.decodeObjectForKey(PropertyKey.ratingKey) as! Int
        
        self.init(name: name, photo: photo, rating: rating)
    }
}

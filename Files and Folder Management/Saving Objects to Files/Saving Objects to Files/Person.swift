//
//  Person.swift
//  Saving Objects to Files
//
//  Created by Yao Jiqian on 10/01/2018.
//  Copyright © 2018 BigBit Corp. All rights reserved.
//

import Foundation

@objc(Person) class Person : NSObject, NSCoding{
    var firstName : String
    var lastName : String
    
    struct SerializationKey {
        static let firstName = "firstName"
        static let lastName = "lastName"
    }
    
    init(firstName : String, lastName : String){
        self.firstName = firstName
        self.lastName = lastName
        super.init()
    }
    
    convenience override init() {
        self.init(firstName: "Vanda", lastName: "Nahavandipoor")
    }
    
    func encode(with aCoder: NSCoder) {
        aCoder.encode(self.firstName, forKey: SerializationKey.firstName)
        aCoder.encode(self.lastName, forKey: SerializationKey.lastName)
    }
    
    required init(coder aDecoder: NSCoder) {
        self.firstName = aDecoder.decodeObject(forKey: SerializationKey.firstName) as! String
        
        self.lastName = aDecoder.decodeObject(forKey: SerializationKey.lastName) as! String
    }
    
    
    static func ==(left : Person, right : Person) -> Bool{
        return left.firstName == right.firstName && left.lastName == right.lastName ? true:false
    }
    
}




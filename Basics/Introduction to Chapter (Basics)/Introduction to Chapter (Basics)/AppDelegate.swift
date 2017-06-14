//
//  AppDelegate.swift
//  Introduction to Chapter (Basics)
//
//  Created by Yao Jiqian on 1/14/16.
//  Copyright © 2016 BigBit Corp. All rights reserved.
//

import UIKit

//typealias byte = UInt8

class Person {
    var age : Int
    var (firstName, lastName) = ("", "")
    
    init (firstName : String, lastName : String, age : Int){
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
}

func == (left : Person, right : Person) -> Bool
{
    if left.firstName == right.firstName &&
        left.lastName == right.lastName {
            return true
    }
    return false
}

postfix func ++(person: inout Person) -> Person
{
    let newPerson = Person(firstName: person.firstName, lastName: person.lastName, age: person.age)
    person.age += 1
    return newPerson
}

prefix func ++(person: inout Person) -> Person
{
    person.age += 1
    let newPerson = Person(firstName: person.firstName, lastName: person.lastName, age: person.age)
    return newPerson
}


enum CarClassification : String
{
    case Estate = "Estate"
    case Hatchback = "HachBack"
    case Saloon = "Saloon"
}

struct Car {
    let classification : CarClassification
    let year : Int
}


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func changeFirstNameOf( _ person : Person, to : String)
    {
        person.firstName = to
    }
    
    func classifyCar(_ car : Car)
    {
        switch car.classification{
        case .Saloon where car.year >= 2013:
            print("This is a good and usable Estate car")
        case .Hatchback where car.year >= 2010:
            print("This is okey car")
        default:
            print("Unhandled case")
        }
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        var vandad = Person(firstName: "Vandad", lastName: "Nahavandipoor", age : 25)
        changeFirstNameOf(vandad, to: "VANDAD")
        
        var sameVandad = ++vandad
        
        var oldVandad = vandad++
        
        let byte3 = 0b01010101 | 0b10101010
        
        let plus = 10 + 20
        
        let mimus = 20 - 10
        
        let miltiplied = 10 * 20
        
        let division = 10.0 / 3.0
        
        
        let andy = Person(firstName: "Andy", lastName: "Oram", age : 25)
        let someoneElse = Person(firstName: "Andy1", lastName: "Oram", age : 45)
        
        if andy == someoneElse {
            print("They are the same")
        }else{
            print("They are not the same")
        }
        
        let volvoV50 = Car(classification: .Estate, year :2005)
        print(volvoV50.classification.rawValue)
        
        switch volvoV50.classification{
        case .Estate:
            print("This is a good family car.")
        case .Hatchback:
            print("Nice car, but no big emough for family.")
        default:
            print("I don't understand this CarClassification.")
        }
        
        let oldEstate = Car(classification: .Estate, year: 1980)
        let estate = Car(classification: .Estate, year: 2010)
        let newEstate = Car(classification: .Estate, year: 2015)
        let hatchback = Car(classification: .Hatchback, year: 2013)
        let newSaloon = Car(classification: .Saloon, year: 2015)
        
        classifyCar(oldEstate) /* Will go to the default case */
        classifyCar(estate) /* Will go to the default case */
        classifyCar(newEstate) /* Will be picked up in the function */
        classifyCar(hatchback) /* Will be picked up in the function */
        classifyCar(newSaloon) /* Will go to the default case */
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


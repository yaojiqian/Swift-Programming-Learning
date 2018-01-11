//
//  AppDelegate.swift
//  Performing Batch Updates on Core Data
//
//  Created by Yao Jiqian on 10/01/2018.
//  Copyright © 2018 BigBit Corp. All rights reserved.
//

import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let entityName = NSStringFromClass(Person.classForCoder())
    
    func populateDataBase(){
        //let appDel:AppDelegate = (UIApplication.shared.delegate as! AppDelegate)
        let managedObjectContext : NSManagedObjectContext = persistentContainer.viewContext
        
        for counter in 0..<1000{
            let person = NSEntityDescription.insertNewObject(forEntityName: entityName, into: managedObjectContext) as! Person
            
            person.firstName = "First Name \(counter)"
            person.lastName = "Last Name\(counter)"
            person.age = Int32(arc4random_uniform(120))
            
        }
        //do{ try managedObjectContext.save() } catch{debugPrint("save failed.")}
        self.saveContext()
        debugPrint("Managed to populate the database")
    }

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        //populateDataBase()
        let batch = NSBatchUpdateRequest(entityName: entityName)
        batch.propertiesToUpdate = ["age" : 18]
        batch.predicate = NSPredicate(format: "age < %@", 18 as NSNumber)
        batch.resultType = .updatedObjectsCountResultType
        
        
        do {
            let result = try persistentContainer.viewContext.execute(batch)
            
            if let theResult = result as? NSBatchUpdateResult {
                if let numberOfAffectPersons = theResult.result as? Int{
                    debugPrint("Number of people who were previously younger than " +
                        "18 years old and whose age is now set to " +
                        "18 is \(numberOfAffectPersons)")
                }
                
            }else{
                debugPrint("result is nil")
            }
        } catch{
            debugPrint("update failed")
        }
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        // Saves changes in the application's managed object context before the application terminates.
        self.saveContext()
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Performing_Batch_Updates_on_Core_Data")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}


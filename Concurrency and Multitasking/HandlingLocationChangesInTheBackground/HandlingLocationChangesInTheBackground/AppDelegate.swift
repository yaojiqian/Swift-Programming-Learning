//
//  AppDelegate.swift
//  HandlingLocationChangesInTheBackground
//
//  Created by Yao Jiqian on 18/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit
import CoreLocation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, CLLocationManagerDelegate {

    var window: UIWindow?
    var locationManager : CLLocationManager?
    var isExecutingInBackground = false


    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        locationManager = CLLocationManager()
        locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        locationManager?.delegate = self
        locationManager?.startUpdatingLocation()
        
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        isExecutingInBackground = true
        
        /* Reduce the accuracy to ease the strain on
         iOS while we are in the background */
        locationManager?.desiredAccuracy = kCLLocationAccuracyHundredMeters
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        isExecutingInBackground = false
        
        /* Now that our app is in the foreground again, let's increase the location detection accuracy */
        locationManager!.desiredAccuracy = kCLLocationAccuracyBest
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]){
        if isExecutingInBackground{
            /* We are in the background. Do not do any heavy processing */
        }else{
            /* We are in the foreground. Do any processing that you wish */
        }
    }
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


//
//  AppDelegate.swift
//  FiringPeriodicTasks
//
//  Created by Yao Jiqian on 15/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var paintingTimer : Timer?
    
    func paint(paramTimer:Timer){
        print("Painting...")
    }
    
    func startPainting(){
        stopPainting()
        print("start painting...")
        //the time becomes a scheduled timer and will fire the event you request.
        paintingTimer = Timer.scheduledTimer(timeInterval: 1.0, target: self, selector: #selector(paint), userInfo: nil, repeats: true)
    }

    func stopPainting(){
        if let timer = paintingTimer{
            timer.invalidate()
            //The invalidate method will also release the timer, 
            //so that we don’t have to do that manually.
            paintingTimer = nil
        }
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationWillResignActive(_ application: UIApplication) {
        stopPainting()
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        startPainting()
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}


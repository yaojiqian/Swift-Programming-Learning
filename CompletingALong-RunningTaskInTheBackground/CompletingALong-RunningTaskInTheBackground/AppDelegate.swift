//
//  AppDelegate.swift
//  CompletingALong-RunningTaskInTheBackground
//
//  Created by Yao Jiqian on 16/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var backgroundTaskIndentifier : UIBackgroundTaskIdentifier = UIBackgroundTaskInvalid
    
    var myTimer : Timer?
    
    func isMultitaskingSupported() -> Bool{
        return UIDevice.current.isMultitaskingSupported
    }
    
    func timerMethod(sender : Timer){
        let backgroundTimeRemaining = UIApplication.shared.backgroundTimeRemaining
        
        if backgroundTimeRemaining == Double.greatestFiniteMagnitude{
            print("Background time remaining = Undetermined")
        }else{
            print("Background time remaining \(backgroundTimeRemaining) seconds")
        }
    }
    
    

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        return true
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        
        if isMultitaskingSupported() == false{
            print("Multitasking is not supported.")
            return
        }
        
        myTimer = Timer(timeInterval: 1.0, target: self, selector: #selector(timerMethod), userInfo: nil, repeats: true)
        if let tt = myTimer{
            RunLoop.main.add(tt, forMode: .commonModes)
        }
        backgroundTaskIndentifier = application.beginBackgroundTask(withName: "Task1", expirationHandler: {[weak self] in
            self!.endBackgroundTask()
            print("Task1 expired.")
        })
        
        if backgroundTaskIndentifier == UIBackgroundTaskInvalid{
            print("backgroundTaskIndentifier is invalid.")
        }else{
            print("backgroundTaskIndentifier = \(backgroundTaskIndentifier)")
        }
    }
    
    func endBackgroundTask(){
        let mainQueue = DispatchQueue.main;
        
        mainQueue.async(execute: {[weak self] in
            if let timer = self!.myTimer{
                timer.invalidate()
                self!.myTimer = nil
                UIApplication.shared.endBackgroundTask(self!.backgroundTaskIndentifier)
                self!.backgroundTaskIndentifier = UIBackgroundTaskInvalid
            }})
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        if backgroundTaskIndentifier != UIBackgroundTaskInvalid{
            endBackgroundTask()
        }
    }

}


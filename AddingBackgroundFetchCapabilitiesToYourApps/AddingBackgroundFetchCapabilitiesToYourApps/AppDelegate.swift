//
//  AppDelegate.swift
//  AddingBackgroundFetchCapabilitiesToYourApps
//
//  Created by Yao Jiqian on 17/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit


struct NewsItem{
    var date : Date
    var text : String
}

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    var newsItems = [NewsItem]()
    
    /* The name of the notification that we will send when our news items are changed */
    class func newsItemsChangedNotification() -> String {
        return "\(#function)"
    }

    func fetchNewsItems()->Bool{
        
        //if arc4random_uniform(2) != 1{
        //    return false
        //}
        
        let newsItem = NewsItem(date: Date(), text: "News Item \(newsItems.count + 1)")
        
        newsItems.append(newsItem)
        
        /* Send a notification to observers telling them that a news item is now available */
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: type(of: self).newsItemsChangedNotification()), object: nil)
        
        return true
    }
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        newsItems.append(NewsItem(date:Date(), text:"News Item 1"))
        application.setMinimumBackgroundFetchInterval(UIApplicationBackgroundFetchIntervalMinimum)
        
        return true
    }

    func application(_ application: UIApplication, performFetchWithCompletionHandler completionHandler:@escaping (UIBackgroundFetchResult) -> Void){
        
        if self.fetchNewsItems(){
            completionHandler(.newData)
        }else{
            completionHandler(.noData)
        }
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
    }


}


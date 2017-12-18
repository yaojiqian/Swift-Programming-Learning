//
//  AppDelegate.swift
//  PlayingAudioInTheBackground
//
//  Created by Yao Jiqian on 18/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit
import AVFoundation

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AVAudioPlayerDelegate {

    var window: UIWindow?
    
    var audioPlayer : AVAudioPlayer?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        let dispatchQueue = DispatchQueue.global(qos: .default)
        
        dispatchQueue.async {
            [weak self] in
            //var audioError : Error?
            let audioSession = AVAudioSession.sharedInstance()
            
            NotificationCenter.default.addObserver(self!, selector: #selector(self!.handleInterruption), name: NSNotification.Name.AVAudioSessionInterruption, object: nil)
            
            do{
                try audioSession.setActive(true)
                try audioSession.setCategory(AVAudioSessionCategoryPlayback)
            }catch{
                print("Could not set the audio session")
            }
            
            do{
                let filePath = Bundle.main.path(forResource: "MySong", ofType: "mp3")
                let fileData = try NSData(contentsOfFile: filePath!, options: NSData.ReadingOptions.dataReadingMapped)
                
                
                /* Start the audio player */
                self!.audioPlayer = try AVAudioPlayer(data: fileData as Data)
                /* Did we get an instance of AVAudioPlayer? */
                if let thePlayer = self!.audioPlayer{
                    thePlayer.delegate = self
                    if thePlayer.prepareToPlay() && thePlayer.play() {
                        print("Successfully started playing")
                    }
                }
            }catch{
                print("something wrong while try to play.")
            }
        }
        
        return true
    }

    func handleInterruption(notification: Notification){
        /* Audio Session is interrupted. The player will be paused here */
        let interruptionTypeAsObject = notification.userInfo![AVAudioSessionInterruptionTypeKey] as! NSNumber
        
        let interruptionType = AVAudioSessionInterruptionType(rawValue: interruptionTypeAsObject.uintValue)
        if let type = interruptionType {
            if type == .ended{
                //audioPlayer!.play()
                let ti = TimeInterval(0.0)
                audioPlayer?.play(atTime: ti)
            }
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


//
//  ViewController.swift
//  Downloading Data in the Background Using URLSession
//
//  Created by Yao Jiqian on 28/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDelegate, URLSessionTaskDelegate, URLSessionDownloadDelegate {
    
    var session : URLSession!
    
    /* This computed property will generate a unique identifier for our background session configuration. The first time it is used, it will get the current date and time and return that as a string to you. It will also save that string into the system defaults so that it can retrieve it the next time it is called. This computed property's value is persistent between launches of this app. */
    var configurationIdentifier : String{
        let userDefaults = UserDefaults.standard
        /* Designate a key that makes sense to your app */
        let key = "configurationIdentifier"
        let previouseValue = userDefaults.string(forKey: key)
        
        if let thePreviouseValue = previouseValue {
            return thePreviouseValue
        }else{
            let newValue = Date().description
            userDefaults.set(newValue, forKey: key)
            userDefaults.synchronize()
            return newValue
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder : aDecoder)
        
        /* Create our configuration first */
        let configuration = URLSessionConfiguration.background(withIdentifier: configurationIdentifier)
        configuration.timeoutIntervalForRequest = 15.0
        
        /* Now create a session that allows us to create the tasks */
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }
    
    /* Just a little method to help us display alert dialogs to the user */
    func displayAlertWithTitle(_ title: String, message: String){
        let controller = UIAlertController(title: title, message: message, preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "OK",
                                           style: .default,
                                           handler: nil))
        present(controller, animated: true, completion: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        /* Now attempt to download the contents of the URL */
        //let url = URL(string : "https://yaojiqian.github.io")
        let url = URL(string : "https://www.baidu.com")
        
        let task = session.downloadTask(with: url!)
        
        task.resume()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didResumeAtOffset fileOffset: Int64, expectedTotalBytes: Int64) {
        
        print("Recieved data.")
    }

    /* We now get to know that the download procedure finished */
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        print("Finished")
        
        if error == nil{
            print("Without error.")
        }else{
            print("with a error = \(error!)")
        }
        
        /* Release the delegate */
        session.finishTasksAndInvalidate()
    }
    
    func urlSession(_ session: URLSession, downloadTask: URLSessionDownloadTask, didFinishDownloadingTo location: URL) {
        
        print("Finished writing the download content to URL=\(location)")
    }
}


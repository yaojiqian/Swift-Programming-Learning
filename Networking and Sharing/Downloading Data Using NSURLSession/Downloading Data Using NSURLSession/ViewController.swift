//
//  ViewController.swift
//  Downloading Data Using NSURLSession
//
//  Created by Yao Jiqian on 27/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController , URLSessionDelegate{
    
    var session : URLSession!
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
        /* Create our configuration first */
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15.0
        
        /* Now create our session which will allow us to create the tasks */
        session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Now attempt to download the contents of the URL */
        let url = URL(string: "https://yaojiqian.github.io")
        
        //let task = session.dataTask(with: url!, completionHandler: {[weak self] (data : Data?, response :URLResponse?, error : Error?) in
        
            /* We got our data here */
            //print("Done")
            //if let str = String(data: data!, encoding: String.Encoding.utf8) {
            //    print(str)
            //}else{
            //    print(data!)
            //}
        let task = session.downloadTask(with: url!, completionHandler: {[weak self] (url :URL?, response : URLResponse?, error : Error?) in
            
            if error == nil {
                let manager = FileManager()
                
                /* Get the path to the caches folder */
                //var err = Error?
                do{
                    var distinationPath = try manager.url(for: .cachesDirectory, in: .userDomainMask, appropriateFor: url, create: true)
                    
                    /* Extract the last part of the source URL, which is the name of the file we are downloading */
                    let componentsOfUrl = url?.absoluteString.components(separatedBy: "/")
                    let fileNameFromUrl = componentsOfUrl?[(componentsOfUrl?.count)! - 1]
                    distinationPath = distinationPath.appendingPathComponent(fileNameFromUrl!)
                    
                    /* Now move the file over */
                    //try manager.moveItem(at: url!, to: distinationPath)
                    try manager.copyItem(at: url!, to: distinationPath)
                    
                    let msg = "Saved the download data to \(distinationPath)"
                    
                    self!.displayAlertWithTitle(title: "Success", message: msg)
                    
                }catch{
                    self!.displayAlertWithTitle(title: "Exception", message: "Exception occurred, while file operations.")
                }
            }else{
                self!.displayAlertWithTitle(title: "Error", message: "Could not download the data, An error occurred.")
            }
            
            self!.session.finishTasksAndInvalidate()
        })
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    /* Just a little method to help us display alert dialogs to the user */
    func displayAlertWithTitle(title : String, message : String){
        
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alertController, animated: true)
    }
}


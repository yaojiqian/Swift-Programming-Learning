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
        
        let task = session.dataTask(with: url!, completionHandler: {[weak self] (data : Data?, response :URLResponse?, error : Error?) in
            
            /* We got our data here */
            print("Done")
            if let str = String(data: data!, encoding: String.Encoding.utf8) {
                print(str)
            }else{
                print(data!)
            }
            
            self!.session.finishTasksAndInvalidate()
        })
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


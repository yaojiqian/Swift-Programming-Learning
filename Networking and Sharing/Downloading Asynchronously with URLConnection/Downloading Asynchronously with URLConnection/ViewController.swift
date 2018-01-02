//
//  ViewController.swift
//  Downloading Asynchronously with URLConnection
//
//  Created by Yao Jiqian on 02/01/2018.
//  Copyright © 2018 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Construct the URL and the request to send to the connection */
        let urlString = "http://www.apple.com"
        let url = URL(string : urlString)
        let urlRequest = URLRequest(url: url!)
        
        /* We do the asynchronous request on our queue */
        //let queue = OperationQueue()
        let session = URLSession.shared
        
        let task = session.dataTask(with: urlRequest) { (data, response, error) in
            print(String(data : data!, encoding : String.Encoding.utf8)!)
        }
     
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


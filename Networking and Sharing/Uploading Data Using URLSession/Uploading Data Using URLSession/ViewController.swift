//
//  ViewController.swift
//  Uploading Data Using URLSession
//
//  Created by Yao Jiqian on 28/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, URLSessionDelegate, URLSessionDataDelegate {
    
    var session : URLSession!
    
    required init?(coder aDecoder : NSCoder){
        super.init(coder: aDecoder)
        
        /* Create our configuration first */
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 15.0
        
        /* Now create a session that allows us to create the tasks */
        session = URLSession(configuration : configuration, delegate : self, delegateQueue: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        /* Now attempt to upload to the following URL */
        
        let dataToUpload = "name=Ravi&loc=India&age=31".data(using: String.Encoding.utf8, allowLossyConversion: false)
        //let dataToUpload = "Hello World".data(using: String.Encoding.utf8, allowLossyConversion: false)
        
        let url = URL(string : "http://posttestserver.com/post.php")
        var request = URLRequest(url: url!)
        //let request = NSMutableURLRequest(url: url!)
        request.httpMethod = "POST"
        //request.addValue("Hello", forHTTPHeaderField: "aaa")
        //request.addValue("world", forHTTPHeaderField: "bbb")
        print(request.debugDescription)
        
        let task = session.uploadTask(with: request as URLRequest, from: dataToUpload!)
        
        task.resume()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayAlertWithTitle(_ title : String, message: String){
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        
        present(alertController, animated: true)
    }

    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        
        /* Now you have your data in the mutableData property */
        session.finishTasksAndInvalidate()
        
        if let theError = error {
            print("error =\(theError)")
        }
        
        DispatchQueue.main.async {[weak self] in
            var message = "Finished uploading your content"
            
            if error != nil{
                message = "Failed to upload your content"
            }
            
            self!.displayAlertWithTitle("Done", message: message)
        }
    }

    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        
        let ss = String(bytes: data, encoding: String.Encoding.utf8)
        
        //displayAlertWithTitle("Received", message: ss!)
        print(ss!)
    }
}


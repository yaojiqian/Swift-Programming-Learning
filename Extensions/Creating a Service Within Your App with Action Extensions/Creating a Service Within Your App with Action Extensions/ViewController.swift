//
//  ViewController.swift
//  Creating a Service Within Your App with Action Extensions
//
//  Created by Yao Jiqian on 05/06/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit
import MobileCoreServices

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    
    let type = kUTTypeText
    
    @IBAction func performShare(_ sender: UIBarButtonItem) {
        let controller = UIActivityViewController(activityItems: [textField.text!], applicationActivities:nil)
        controller.completionWithItemsHandler = activityCompletionHandler
        present(controller, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func activityCompletionHandler(activityType: UIActivityType?, completed: Bool, returnedItems: [Any]?,activityError: Error?){
        
        if completed && activityError == nil{
            let item = returnedItems?[0] as! NSExtensionItem
            
            if let attachments = item.attachments {
                
                let attachment = attachments[0] as! NSItemProvider
                
                if attachment.hasItemConformingToTypeIdentifier(type as String){
                    attachment.loadItem(forTypeIdentifier: type as String, options: nil, completionHandler: {
                        [weak self] (item, error) in
                        let strongSelf = self!
                        if error != nil{
                            strongSelf.textField.text = "\(error)"
                        }
                        else{
                            if let value = item as? NSString{
                                strongSelf.textField.text = value as String
                            }
                        }
                    })
                }
                
            }
            
        }
    }
    
}


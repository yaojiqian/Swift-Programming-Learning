//
//  ActionViewController.swift
//  Uppercase Extension
//
//  Created by Yao Jiqian on 05/06/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit
import MobileCoreServices

class ActionViewController: UIViewController {

    let type = kUTTypeText
    
    @IBOutlet weak var textView: UITextView!

    @IBAction func cancel(_ sender: Any) {
        let userInfo = [NSLocalizedDescriptionKey: "User Cancelled"]
        let error = NSError(domain: "Extension", code: -1, userInfo: userInfo)
        extensionContext!.cancelRequest(withError: error)
    }
    
    @IBAction func done(_ sender: Any) {
        
        let extensionItem = NSExtensionItem()
        let text = textView.text
        let itemProvider = NSItemProvider(item: text as NSSecureCoding?, typeIdentifier: type as String)
        extensionItem.attachments = [itemProvider]
        let itemToShare = [extensionItem]
        
        extensionContext!.completeRequest(returningItems: itemToShare, completionHandler: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Get the item[s] we're handling from the extension context.
        
        // For example, look for an image and place it into an image view.
        // Replace this with something appropriate for the type[s] your extension supports.
        for item in self.extensionContext!.inputItems as! [NSExtensionItem] {
            for provider in item.attachments! as! [NSItemProvider] {
                if provider.hasItemConformingToTypeIdentifier(kUTTypeText as String) {
                    // This is an image. We'll load it, then place it in our image view.
                    weak var weakTextView = self.textView
                    provider.loadItem(forTypeIdentifier: type as String, options: nil, completionHandler: { (text, error) in
                        OperationQueue.main.addOperation {
                            if let strongTextView = weakTextView {
                                strongTextView.text = (text as! String).uppercased()
                            }
                        }
                    })
                    
                    break
                }
            }
            
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

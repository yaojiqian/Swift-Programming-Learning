//
//  ShareViewController.swift
//  Sharing Extension
//
//  Created by Yao Jiqian on 02/06/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit
import Social
import MobileCoreServices

class ShareViewController: SLComposeServiceViewController, URLSessionDelegate, AudienceSelectionViewControllerDelegate{

    var imageData : NSData?
    
    lazy var audienceConfigurationItem : SLComposeSheetConfigurationItem = {
        let item = SLComposeSheetConfigurationItem()
        item!.title = "Audience"
        item!.value = AudienceSelectionViewController.defaultAudience()
        item!.tapHandler = self.showAudienceSelection
        return item!
    }()
    
    override func isContentValid() -> Bool {
        /* The post button should be enabled only if we have the image data and the user has entered at least one character of text */
        
        if imageData != nil {
            if !(contentText as String).isEmpty {
                return true
            }
        }
        
        return true
    }

    override func presentationAnimationDidFinish() {
        super.presentationAnimationDidFinish()
        
        let content = extensionContext!.inputItems[0] as! NSExtensionItem
        
        let contentType = kUTTypeImage as NSString
        
        for attachment in content.attachments as! [NSItemProvider] {
            if attachment.hasItemConformingToTypeIdentifier(contentType as String){
                let dispatchQueue = DispatchQueue.global()
                
                dispatchQueue.async(execute: {[weak self] in
                    let strongSelf = self!
                    
                    attachment.loadItem(forTypeIdentifier: contentType as String,
                            options: nil,
                            completionHandler: {(content: NSSecureCoding?, error: NSError!) in
                                if let data = content as? NSData{
                                    let mainDisptchQueue = DispatchQueue.main
                                    mainDisptchQueue.async {
                                        strongSelf.imageData = data
                                        strongSelf.validateContent()
                                    }
                                }
                    } as? NSItemProvider.CompletionHandler)
                })
            }
        }
    }
    
    override func didSelectPost() {
        
        let identifier = Bundle.main.bundleIdentifier! + "." + UUID().uuidString
        
        let configuration = URLSessionConfiguration.background(withIdentifier: identifier)
        
        let session = URLSession(configuration: configuration, delegate: self, delegateQueue: nil)
        
        let url = URL(string: "http://my.com/boom/&text=" + self.contentText)
        
        var request = URLRequest(url: url!)
        request.httpMethod = "POST"
        request.httpBody = imageData! as Data
        
        let task = session.uploadTask(with: request, from: request.httpBody!)
        
        task.resume()
        
        extensionContext!.completeRequest(returningItems: [], completionHandler: nil)
        
    }

    override func configurationItems() -> [Any]! {

        return [audienceConfigurationItem]
    }
    
    func showAudienceSelection(){
        let controller = AudienceSelectionViewController(style: .plain)
        controller.audience = audienceConfigurationItem.value
        controller.delegate = self
        pushConfigurationViewController(controller)
    }

    func audienceSelectionViewController(sender: AudienceSelectionViewController, selectedValue: String){
        audienceConfigurationItem.value = selectedValue
        popConfigurationViewController()
    }
    
}

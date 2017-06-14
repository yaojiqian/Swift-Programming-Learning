//
//  ViewController.swift
//  Presenting Sharing Options with UIActivityViewController
//
//  Created by Yao Jiqian on 5/24/17.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    
    var textField : UITextField!
    var buttonShare : UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createButton()
        createTextField()
    }


    func createTextField(){
        textField = UITextField(frame: CGRect(x: 20, y: 35, width: 280, height: 30))
        textField.borderStyle = .roundedRect
        textField.placeholder = "Enter text to share..."
        textField.delegate = self
        
        view.addSubview(textField)
    }
    
    func createButton(){
        buttonShare = UIButton(type: .system)
        buttonShare.frame = CGRect(x: 20, y: 80, width: 280, height: 44)
        buttonShare.setTitle("Share", for:.normal)
        buttonShare.addTarget(self, action:#selector(handleShare), for: .touchUpInside)
        
        view.addSubview(buttonShare)
    }
    
    func handleShare(sender: UIButton){
        if (textField.text?.isEmpty)!{
            let message = "Please enter a text and then press Share"
            let alertController = UIAlertController(title: nil, message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
            return
        }
        
        /* it is VERY important to cast your strings to NSString
         otherwise the controller cannot display the appropriate sharing options */
        let activityViewController = UIActivityViewController(activityItems: [textField.text!],applicationActivities: nil)
        activityViewController.excludedActivityTypes = [ .airDrop, .postToFacebook ]

        present(activityViewController, animated: true, completion: {})
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool{
        textField.resignFirstResponder()
        return true
    }
}

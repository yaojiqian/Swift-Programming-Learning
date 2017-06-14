//
//  ViewController.swift
//  Displaying Long Lines of Text with UITextView
//
//  Created by Yao Jiqian on 25/05/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var textView : UITextView!
    
    let defaultContentInset = UIEdgeInsets(top: 10, left: 0, bottom: 0, right: 0)
    
    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        textView = UITextView(frame: view.bounds)
        
        if let theTextView = textView{
            theTextView.text = "Some text goes here ..."
            
            theTextView.contentInset = defaultContentInset
            
            theTextView.font = UIFont.systemFont(ofSize: 16)
            view.addSubview(theTextView)
            
            NotificationCenter.default.addObserver(self, selector: #selector(handleDidKeyboardShow),
                                                             name: NSNotification.Name.UIKeyboardDidShow,
                                                             object: nil)
            
            NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        }
        
    }

    func handleDidKeyboardShow(notification: NSNotification){
        /*Get the frame of the keyboard*/
        let keyboardRectAsObject = notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue
        
        /*Place it in Rect*/
        var keyboardRect = CGRect.zero
        
        /**/
        keyboardRectAsObject.getValue(&keyboardRect)
        
        textView.contentInset = UIEdgeInsets(top: defaultContentInset.top, left: 0,
                                             bottom: keyboardRect.height, right: 0)
    }
    
    func handleKeyboardWillHide(notification: NSNotification){
        textView.contentInset = defaultContentInset
    }

}


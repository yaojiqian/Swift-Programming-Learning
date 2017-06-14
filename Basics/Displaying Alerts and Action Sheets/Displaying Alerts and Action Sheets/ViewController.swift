//
//  ViewController.swift
//  Displaying Alerts and Action Sheets
//
//  Created by Yao Jiqian on 5/23/17.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var controller : UIAlertController?
    var button : UIButton!
    
    func buttonClick(sender : UIButton){
        self.present(controller!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        button = UIButton(type: .system)
        button.frame = CGRect(x:20, y: 100, width: 100, height: 50)
        button.setTitle("Alert", for: .normal)
        button.addTarget(self, action: #selector(buttonClick), for: .touchDown)
        
        view.addSubview(button)
        
        controller = UIAlertController(title: "Title", message: "Message", preferredStyle: .alert)
        controller!.addTextField(configurationHandler: {
            (textField: UITextField) in textField.placeholder = "XXXXXXXXXX"
        })
        
        let action = UIAlertAction(title: "Done", style: .default, handler: {
            (perform: UIAlertAction!) in
            print("Done button selected.")
        })
        
        let nextAction = UIAlertAction(title: "next", style: .default, handler:{
            [weak self](perform:UIAlertAction!) in
            if let textFields = self?.controller?.textFields{
                let theTextFields = textFields as [UITextField]
                let username = theTextFields[0].text!
                print("the user name :\(username).")
            }
        })
        let actionDelete = UIAlertAction(title: "Delete photo", style: .destructive,
            handler: {(paramAction:UIAlertAction!) in
                print("Delete photo selected.")
        })
        
        controller!.addAction(action)
        controller!.addAction(nextAction)
        controller!.addAction(actionDelete)
        
    }
    
    //override func viewDidAppear(_ animated: Bool) {
    //    super.viewDidAppear(animated)
    //
    //    self.present(controller!, animated: true, completion: nil)
    //}

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


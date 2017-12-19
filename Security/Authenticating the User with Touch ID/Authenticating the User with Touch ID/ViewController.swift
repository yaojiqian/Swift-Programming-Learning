//
//  ViewController.swift
//  Authenticating the User with Touch ID
//
//  Created by Yao Jiqian on 19/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit
import LocalAuthentication

class ViewController: UIViewController {

    @IBOutlet weak var buttonCheckTouchID: UIButton!
    @IBOutlet weak var buttonUseTouchID: UIButton!
    
    @IBAction func checkTouchIDAvailability(_ sender: Any) {
        
        let context = LAContext()
        var error : NSError?
        
        let isTouchIDAvailable = context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error)
        
        buttonUseTouchID.isEnabled = isTouchIDAvailable
        
        /* Touch ID is not available */
        if isTouchIDAvailable == false{
            let alertController = UIAlertController(title: "Touch ID", message: "Touch ID is not available", preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            present(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func useTouchID(_ sender: Any) {
        
        let context = LAContext()
        //var error : Error?
        let reason = "Please authenticate with Touch ID " + "to access your private information"
        
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: reason, reply:{[weak self](success : Bool, error : Error?) in
            var message : String?
            if success {
                message = "Authentication Success!"
            }else{
                message = "Authentication failed!"
            }
            let alertController = UIAlertController(title: "Touch ID", message: message, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self!.present(alertController, animated: true, completion: nil)
        })
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


//
//  ViewController.swift
//  PerformingUI-RelatedTasks
//
//  Created by Yao Jiqian on 21/09/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        DispatchQueue.main.async{ [weak self] in
            let alertController = UIAlertController(title: "GCD", message: "GCD is amazing", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            
            self?.present(alertController, animated: true, completion: nil)
        }
        
        DispatchQueue.main.async {
            print("current thread is \(Thread.current)")
            print("main thread is \(Thread.main)")
        }
    }

}


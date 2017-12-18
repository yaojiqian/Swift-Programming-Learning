//
//  ViewController.swift
//  GroupingTasksTogether
//
//  Created by Yao Jiqian on 15/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    func reloadTableView(){
        print(#function)
        sleep(1)
    }
    
    func reloadScrollView(){
        print(#function)
        sleep(1)
    }
    
    func reloadImageView(){
        print(#function)
        sleep(1)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let taskGroup = DispatchGroup()
        let mainQueue = DispatchQueue.main
        
        /* Reload the table view on the main queue */
        mainQueue.async(group: taskGroup, execute: {[weak self] in self!.reloadTableView() })
        /* Reload the scroll view on the main queue */
        mainQueue.async(group: taskGroup, execute: {[weak self] in self!.reloadScrollView()})
        /* Reload the image view on the main queue */
        mainQueue.async(group: taskGroup, execute: {[weak self] in self!.reloadImageView() })
        
        /* When we are done, dispatch the following block */
        taskGroup.notify(queue: mainQueue, execute: {[weak self] in
            let alertController = UIAlertController(title: "task group", message: "all task have done!", preferredStyle: .alert)
            
            alertController.addAction(UIAlertAction(title:"OK", style:.default, handler: nil))
            
            self!.present(alertController, animated:true, completion:nil)
        })
        
    }
}


//
//  ViewController.swift
//  Presenting Temporary Information on the Screen with Popovers
//
//  Created by Yao Jiqian on 1/15/16.
//  Copyright © 2016 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var selectedItem : String?

    
    @IBOutlet weak var helloLabel: UILabel!
    @IBAction func displayPopover(_ sender: UIBarButtonItem) {
        popoverContentController.modalPresentationStyle = .popover
        popoverContentController.preferredContentSize = CGSize(width:300, height:200)
        popoverContentController.popoverPresentationController?.sourceView = helloLabel
        popoverContentController.popoverPresentationController?.sourceRect = helloLabel.bounds
        
        present(popoverContentController, animated: true)
    }
        
    lazy var popoverContentController: UINavigationController = {
        let controller = PopoverTableViewController(style: .plain)
        controller.selectionHandler = self.selectionHandler
        let navigationController = UINavigationController(rootViewController: controller)
        
        return navigationController
    }()
    
    /*lazy var popoverContentController: PopoverTableViewController = {
        let pcc = PopoverTableViewController(style: .plain)
        pcc.selectionHandler = self.selectionHandler
        
        return pcc
    }()*/

    
    func selectionHandler(selectedItem : String?){
        self.selectedItem = selectedItem
        helloLabel.text = selectedItem
    }
}

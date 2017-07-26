//
//  ViewController.swift
//  EnablingSwipeDeletionofTableViewCells
//
//  Created by Yao Jiqian on 26/07/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate {

    var tableView : UITableView?
    let tvDataSource = TableViewDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView(frame: view.bounds, style: .plain)
        if let theTableView = tableView {
            theTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "identifier")
            
            
            theTableView.dataSource = tvDataSource
            view.addSubview(theTableView)
        }
    }

    func tableView(_ tableView: UITableView, editingStyleForRowAt indexPath: IndexPath) -> UITableViewCellEditingStyle {
        
        return .delete
    }
        
    override func setEditing(_ editing: Bool, animated: Bool) {
        super.setEditing(editing, animated: animated)
    
        tableView!.setEditing(editing, animated: animated)
    }
    
}


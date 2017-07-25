//
//  ViewController.swift
//  PopulatingaTableViewwithData
//
//  Created by Yao Jiqian on 25/07/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var tableView : UITableView?
    let tableData = TableViewSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        if let theTableView = tableView {
            theTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "identifier")
            
            theTableView.dataSource = tableData
            theTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            view.addSubview(theTableView)
        }
    }

}


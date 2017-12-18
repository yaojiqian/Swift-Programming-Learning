//
//  ViewController.swift
//  DisplayingaRefreshControlforTableViews
//
//  Created by Yao Jiqian on 01/08/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource {

    var tableView : UITableView?
    var allTimes = [NSDate]()
    var refreshControl : UIRefreshControl?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        allTimes.append(NSDate())
        
        tableView = UITableView(frame: view.bounds, style: .plain)
        
        if let theTableView = tableView {
            theTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "identifier")
            
            theTableView.dataSource = self
            theTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            refreshControl = UIRefreshControl()
            refreshControl!.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
            theTableView.addSubview(refreshControl!)
            
            view.addSubview(theTableView)
        }
    }

    func handleRefresh(paramSender: AnyObject){
        
        let mainQueue = DispatchQueue.main
        let deadline = DispatchTime.now() + .seconds(1)
        mainQueue.asyncAfter(deadline: deadline){
            self.allTimes.append(NSDate())
            self.refreshControl!.endRefreshing()
            let indexPathOfNewRow = IndexPath(row: self.allTimes.count - 1, section: 0)
            self.tableView!.insertRows(at: [indexPathOfNewRow],with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTimes.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath)
        
        cell.textLabel?.text = "\(allTimes[indexPath.row])"
        
        return cell
    }
}


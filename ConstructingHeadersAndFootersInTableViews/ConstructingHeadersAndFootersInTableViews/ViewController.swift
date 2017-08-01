//
//  ViewController.swift
//  ConstructingHeadersAndFootersInTableViews
//
//  Created by Yao Jiqian on 01/08/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView : UITableView?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView = UITableView(frame: view.bounds, style: .grouped)
        
        if let theTableView = tableView {
            theTableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "identifier")
            
            theTableView.dataSource = self
            theTableView.delegate = self
            theTableView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
            
            view.addSubview(theTableView)
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath)
        
        cell.textLabel?.text = "cell\(indexPath.row)"
        return cell
    }
    
    func newLabelWithTitle(title: String) -> UILabel{
        let label = UILabel()
        label.text = title
        label.backgroundColor = UIColor.clear
        label.sizeToFit()
        
        return label
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return newLabelWithTitle(title: "Section \(section) Header")
    }
    
    //func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
    //    return newLabelWithTitle(title: "Section \(section) Footer")
    //}
    
}


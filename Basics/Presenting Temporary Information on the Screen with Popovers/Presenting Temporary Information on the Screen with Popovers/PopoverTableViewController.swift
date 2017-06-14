//
//  PopoverTableViewController.swift
//  Presenting Temporary Information on the Screen with Popovers
//
//  Created by Yao Jiqian on 5/16/17.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit


extension Array{
    //typealias T = Array.Element
    subscript(path : IndexPath) -> Array.Element{
        return self[path.row]
    }
}

extension IndexPath{
    static func firstIndexPath()->IndexPath{
        return IndexPath(row: 0, section: 0)
    }
}

class PopoverTableViewController:UITableViewController
{
    struct TableViewValues{
        static let indentifier = "Cell"
    }
    
    /* This variable is defined as lazy so that its memory is allocated
     only when it is accessed for the first time. If we don't use this variable, no computation is done
     and no memory is allocated for this variable */
    lazy var items:[String] = {
        var returnValue = [String]()
        for counter in 1...100{
            returnValue.append("Item \(counter)")
        }
        return returnValue
    }()
    
    var cancelBarButtonItem : UIBarButtonItem!
    var selectionHandler : ((_ selectedItem : String) -> Void)?
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!){
        super.init(nibName :nibNameOrNil, bundle :nibBundleOrNil)
        
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: TableViewValues.indentifier)
    }
    
    override init(style : UITableViewStyle){
        super.init(style: style)
        
        tableView.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: TableViewValues.indentifier)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        cancelBarButtonItem = UIBarButtonItem(title: "Cancel", style: .plain, target:self, action:#selector(performCancel))
        
        navigationItem.leftBarButtonItem = cancelBarButtonItem
    }
    
    func performCancel(){
        dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedItem = items[indexPath]
        selectionHandler?(selectedItem)
        dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        preferredContentSize = CGSize(width: 300, height: 200)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewValues.indentifier, for: indexPath) as UITableViewCell
        cell.textLabel?.text = items[indexPath]
        
        return cell
    }
}

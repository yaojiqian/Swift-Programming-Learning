//
//  AudienceSelectionViewController.swift
//  Providing a Custom Sharing Extension
//
//  Created by Yao Jiqian on 04/06/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit


class AudienceSelectionViewController: UITableViewController
{
    struct TableViewValue {
        static let identifier = "Cell"
    }
    
    enum Audience : String{
        case Everyone = "Everyone"
        case Family = "Family"
        case Friends = "Friends"
        static let allValues = [Everyone, Family, Friends]
    }
    
    var delegate : AudienceSelectionViewControllerDelegate?
    
    var audience = Audience.Everyone.rawValue
    
    class func defaultAudience()->String{
        return Audience.Everyone.rawValue
    }
    
    required init(coder aDecoder: NSCoder){
        super.init(coder: aDecoder)!
    }
    
    override init(style: UITableViewStyle){
        super.init(style: style)
        tableView.register(UITableView.classForCoder(), forCellReuseIdentifier: TableViewValue.identifier)
    }
    
    override init(nibName nibNameOrNil: String!, bundle nibBundleOrNil: Bundle!){
        super.init(nibName : nibNameOrNil, bundle : nibBundleOrNil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Audience.allValues.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TableViewValue.identifier, for: indexPath) as UITableViewCell
        
        let text = Audience.allValues[indexPath.row].rawValue
        cell.textLabel?.text = text
        
        if text == audience {
            cell.accessoryType = .checkmark
        }
        else{
            cell.accessoryType = .none
        }
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let theDelegate = delegate {
            let selectedAudience = Audience.allValues[indexPath.row].rawValue
            theDelegate.audienceSelectionViewController!(sender: self, selectedValue: selectedAudience)
        }
    }
}

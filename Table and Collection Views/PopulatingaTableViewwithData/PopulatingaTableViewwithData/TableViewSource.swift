//
//  TableViewSource.swift
//  PopulatingaTableViewwithData
//
//  Created by Yao Jiqian on 25/07/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import Foundation
import UIKit

class TableViewSource : NSObject, UITableViewDataSource
{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        switch section{
        case 0:
            return 3
        case 1:
            return 5
        case 2:
            return 8
        default:
            return 0
        }
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath)
        
        cell.textLabel?.text = "Section \(indexPath.section)" + ", Cell \(indexPath.row)"
        let order = indexPath.section + indexPath.row
        if order % 2 == 0{
            cell.backgroundColor = UIColor.lightGray
        }
        return cell
    }
    
    
}

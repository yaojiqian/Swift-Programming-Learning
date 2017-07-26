//
//  TableViewDataSource.swift
//  EnablingSwipeDeletionofTableViewCells
//
//  Created by Yao Jiqian on 26/07/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import Foundation
import UIKit

class TableViewDataSource : NSObject, UITableViewDataSource
{
    var rowTitles = ["title 1", "title 2", "title 3"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return rowTitles.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "identifier", for: indexPath)
        
        cell.textLabel?.text = rowTitles[indexPath.row]
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete{
            /* First remove this object from the source */
            rowTitles.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .left)
        }
    }
}

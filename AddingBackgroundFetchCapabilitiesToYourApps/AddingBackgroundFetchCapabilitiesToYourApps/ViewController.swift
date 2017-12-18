//
//  ViewController.swift
//  AddingBackgroundFetchCapabilitiesToYourApps
//
//  Created by Yao Jiqian on 17/12/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate, UITableViewDataSource{

    @IBOutlet var tableView: UITableView!
    var mustReloadView = false
    
    var newsItems: [NewsItem]{
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.newsItems
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        /* Listen to when the news items are changed */
        NotificationCenter.default.addObserver(self, selector: #selector(handleNewsItemsChanged), name: NSNotification.Name(rawValue: AppDelegate.newsItemsChangedNotification()), object: nil)
        
        /* Handle what we need to do when the app comes back to the foreground */
        NotificationCenter.default.addObserver(self, selector: #selector(handleAppIsBroughtToForeground), name: NSNotification.Name.UIApplicationWillEnterForeground, object: nil)
        
    }
    
    /* If there is need to reload after we come back to the foreground, do it here */
    func handleAppIsBroughtToForeground(notification: NSNotification){
        if mustReloadView{
            tableView.reloadData()
        }
    }
    /* We are being told that new news items are available. Reload the table view */
    func handleNewsItemsChanged(notification: NSNotification) {
        
        if self.isBeingPresented{
            tableView.reloadData()
        }else{
            mustReloadView = true
        }
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return newsItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = newsItems[indexPath.row].text
        return cell
    }

    deinit{
        NotificationCenter.default.removeObserver(self)
    }
    
}


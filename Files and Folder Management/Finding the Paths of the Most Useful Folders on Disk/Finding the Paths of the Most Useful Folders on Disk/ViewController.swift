//
//  ViewController.swift
//  Finding the Paths of the Most Useful Folders on Disk
//
//  Created by Yao Jiqian on 10/01/2018.
//  Copyright © 2018 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let fileManager = FileManager()
        let docUrls = fileManager.urls(for: .documentDirectory, in: .userDomainMask)
        
        if docUrls.count > 0 {
            for url in docUrls {
                debugPrint(url)
            }
        }else{
            debugPrint("Finding the Paths of the Most Useful Folders on Disk")
        }
        
        let cacheUrls = fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
        if cacheUrls.count > 0 {
            for url in cacheUrls{
                debugPrint(url)
            }
        }else{
            debugPrint("Could not find the Cache folder")
        }
        
        let tempDir = fileManager.temporaryDirectory
        debugPrint(tempDir)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


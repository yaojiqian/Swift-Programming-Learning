//
//  ViewController.swift
//  Saving Objects to Files
//
//  Created by Yao Jiqian on 10/01/2018.
//  Copyright © 2018 BigBit Corp. All rights reserved.
//

import UIKit



class ViewController: UIViewController {
    
    var writeButton : UIButton?
    var readButton : UIButton?
    
    var firstPerson : Person?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        firstPerson = Person(firstName: "Yao", lastName : "JQ")

        writeButton = UIButton(type: .system)
        if let wbtn = writeButton {
            wbtn.frame = CGRect(x: 0, y: 0, width: 170, height: 70)
            wbtn.setTitle("write person", for: .normal)
            wbtn.addTarget(self, action: #selector(writePersonToFile), for: .touchUpInside)
            view.addSubview(wbtn)
        }
        
        readButton = UIButton(type: .system)
        if let rbtn = readButton {
            rbtn.frame = CGRect(x: 0, y: 80, width: 170, height: 70)
            rbtn.setTitle("read person", for: .normal)
            rbtn.addTarget(self, action: #selector(readPersonFromFile), for: .touchUpInside)
            view.addSubview(rbtn)
        }
        
    }
    
    func writePersonToFile(){
        let fileManager = FileManager()
        let path = fileManager.temporaryDirectory.appendingPathComponent("person")
        
        NSKeyedArchiver.archiveRootObject(firstPerson!, toFile: path.path)
    }
    
    func readPersonFromFile(){
        let fileManager = FileManager()
        let path = fileManager.temporaryDirectory.appendingPathComponent("person")
        
        let secondPerson = NSKeyedUnarchiver.unarchiveObject(withFile: path.path) as! Person
        
        if firstPerson! == secondPerson{
            debugPrint("firstPerson == secondPerson")
        }else{
            debugPrint("firstPerson != secondPerson")
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


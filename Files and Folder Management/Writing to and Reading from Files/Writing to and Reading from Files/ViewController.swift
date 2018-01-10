//
//  ViewController.swift
//  Writing to and Reading from Files
//
//  Created by Yao Jiqian on 10/01/2018.
//  Copyright © 2018 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var writeButton : UIButton?
    var readButton : UIButton?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //create write button.
        writeButton = UIButton(type:.system)
        if let btn = writeButton{
            btn.frame = CGRect(x: 0, y: 0, width: 170, height: 75)
            btn.setTitle("write", for: .normal)
            btn.addTarget(self, action: #selector(writeToFile), for: .touchUpInside)
            view.addSubview(btn)
        }
        
        //create read button
        readButton = UIButton(type: .system)
        if let rbtn = readButton {
            rbtn.frame = CGRect(x: 0, y: 100, width: 170, height: 75)
            rbtn.setTitle("read", for: .normal)
            rbtn.addTarget(self, action: #selector(readFromFile), for: .touchUpInside)
            view.addSubview(rbtn)
        }
    }
    
    func writeToFile(){
        let someText = String("Put some string here: String")
        let fileManager = FileManager()
        let destinationPath = fileManager.temporaryDirectory.appendingPathComponent("myfile.txt")
        
        do { try someText!.write(to: destinationPath, atomically: true, encoding: String.Encoding.utf8) }
        catch {
            debugPrint("write file failed.")
        }
    }
    
    func readFromFile(){
        let fileManager = FileManager()
        let destinationPath = fileManager.temporaryDirectory.appendingPathComponent("myfile.txt")
        
        do{
            let str = try String(contentsOf: destinationPath, encoding: String.Encoding.utf8)
            debugPrint(str)
        }catch {
            debugPrint("read file failed.")
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


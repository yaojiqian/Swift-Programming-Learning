//
//  ViewController.swift
//  Displaying Static Text with UILabel
//
//  Created by Yao Jiqian on 5/22/17.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    var label: UILabel!
    var attributeLabel : UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        label = UILabel(frame:CGRect(x:20, y:100, width:100, height:70))
        label.numberOfLines = 0
        //label.adjustsFontSizeToFitWidth = true
        label.text = "iOS Programming CookBook"
        label.font = UIFont.boldSystemFont(ofSize: 14)
        view.addSubview(label)
        
        attributeLabel = UILabel(frame:CGRect(x:20, y:200, width: 100, height:100))
        attributeLabel.backgroundColor = UIColor.clear
        attributeLabel.attributedText = attributedText()
        attributeLabel.sizeToFit()
        view.addSubview(attributeLabel)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func attributedText() -> NSAttributedString{
    
        let string = "iOS SDK Programming" as NSString
        let result = NSMutableAttributedString(string:string as String)
        
        let attributesForFistWord = [
            NSFontAttributeName : UIFont.boldSystemFont(ofSize: 35),
            NSForegroundColorAttributeName : UIColor.red,
            NSBackgroundColorAttributeName : UIColor.black
        ]
    
        let shadow = NSShadow()
        shadow.shadowColor = UIColor.darkGray
        shadow.shadowOffset = CGSize(width:-4, height:-4)
        
        let attributesForSecondWord = [
            NSFontAttributeName : UIFont.boldSystemFont(ofSize: 35),
            NSForegroundColorAttributeName : UIColor.white,
            NSBackgroundColorAttributeName : UIColor.red,
            NSShadowAttributeName : shadow
        ]
        
        let attributesForThirdWord = [
            NSFontAttributeName : UIFont.italicSystemFont(ofSize: 35),
            NSForegroundColorAttributeName : UIColor.black,
            NSBackgroundColorAttributeName : UIColor.brown
        ]
        
        result.setAttributes(attributesForFistWord, range: string.range(of: "iOS"))
        result.setAttributes(attributesForSecondWord, range: string.range(of: "SDK"))
        result.setAttributes(attributesForThirdWord, range : string.range(of: "programming", options: NSString.CompareOptions.caseInsensitive))
        
        return NSAttributedString(attributedString: result)
    }
}


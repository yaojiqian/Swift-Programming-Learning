//
//  ViewController.swift
//  Displaying Images with UIImageView
//
//  Created by Yao Jiqian on 5/18/17.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let image = UIImage(named: "Safari@2x.png")
    var imageView:UIImageView!
    
    required init(coder aDecoder: NSCoder){
        //imageView = UIImageView(image: image)
        super.init(coder: aDecoder)!
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imageView = UIImageView(frame: view.bounds)
        imageView.image = image
        imageView.contentMode = .scaleAspectFit
        imageView.center = view.center
        view.addSubview(imageView)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


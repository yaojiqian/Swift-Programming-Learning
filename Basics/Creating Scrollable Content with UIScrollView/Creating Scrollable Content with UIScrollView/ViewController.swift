//
//  ViewController.swift
//  Creating Scrollable Content with UIScrollView
//
//  Created by Yao Jiqian on 25/05/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIScrollViewDelegate {
    
    var imageView : UIImageView!
    var scrollView : UIScrollView!
    
    let image = UIImage(named: "Safari")

    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView = UIImageView(image:image)
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: view.bounds.width, height : view.bounds.height/2))
        scrollView.indicatorStyle = .white
        
        scrollView.addSubview(imageView)
        scrollView.contentSize = imageView.bounds.size
        
        view.addSubview(scrollView)
    }

    func scrollViewDidScroll(_ scrollView: UIScrollView){
        scrollView.alpha = 0.1
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView){
        scrollView.alpha = 1
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool){
        scrollView.alpha = 1
    }
    
}


//
//  MyCollectionViewCell.swift
//  HandlingEventsInCollectionViews
//
//  Created by Yao Jiqian on 19/09/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit


class MyCollectionViewCell : UICollectionViewCell
{

    @IBOutlet weak var imageViewBackgroundImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        imageViewBackgroundImage.backgroundColor = .clear
        selectedBackgroundView = UIView(frame: bounds)
        selectedBackgroundView?.backgroundColor = .yellow        
    }
}

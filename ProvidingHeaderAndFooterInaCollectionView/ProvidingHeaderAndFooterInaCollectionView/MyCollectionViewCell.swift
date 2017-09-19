//
//  MyCollectionViewCell.swift
//  ProvidingHeaderAndFooterInaCollectionView
//
//  Created by Yao Jiqian on 20/09/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var backgroundImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundImage.backgroundColor = .clear
        selectedBackgroundView = UIView(frame: bounds)
        selectedBackgroundView?.backgroundColor = .blue
    }
}

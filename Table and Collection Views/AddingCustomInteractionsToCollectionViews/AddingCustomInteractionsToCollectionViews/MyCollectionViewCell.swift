//
//  MyCollectionViewCell.swift
//  AddingCustomInteractionsToCollectionViews
//
//  Created by Yao Jiqian on 20/09/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class MyCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var backgroundImagView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        backgroundImagView.backgroundColor = .clear
        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = .blue
    }

}

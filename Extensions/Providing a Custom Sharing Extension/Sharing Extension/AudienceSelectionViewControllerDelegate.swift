//
//  AudienceSelectionViewControllerDelegate.swift
//  Providing a Custom Sharing Extension
//
//  Created by Yao Jiqian on 04/06/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import Foundation

@objc(AudienceSelectionViewControllerDelegate)
protocol AudienceSelectionViewControllerDelegate {
    @objc optional func audienceSelectionViewController(sender : AudienceSelectionViewController, selectedValue: String)
}

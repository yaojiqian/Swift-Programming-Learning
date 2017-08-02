//
//  ViewController.swift
//  ProvidingBasicContentToaCollectionView
//
//  Created by Yao Jiqian on 01/08/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    let allSectionColors = [
        UIColor.red,
        UIColor.green,
        UIColor.blue,
        UIColor.yellow
    ]

    override init(collectionViewLayout layout: UICollectionViewLayout){
        super.init(collectionViewLayout: layout)
        
        collectionView?.register(UICollectionViewCell.classForCoder(), forCellWithReuseIdentifier: "cell")
        
        collectionView?.backgroundColor = UIColor.white
    }
    
    convenience required init(coder aDecoder: NSCoder) {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width:80, height: 120)
        flowLayout.scrollDirection = .vertical
        
        flowLayout.sectionInset = UIEdgeInsets(top : 10, left :20, bottom : 10, right : 20)
        
        self.init(collectionViewLayout: flowLayout)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return allSectionColors.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(arc4random_uniform(21)) + 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath)
        
        let label = UILabel(frame: cell.bounds)
        label.text = "\(indexPath.section) , \(indexPath.row)"
        
        
        cell.backgroundColor = allSectionColors[indexPath.section]
        cell.addSubview(label)
        //cell.contentView = label
        
        return cell
    }

}


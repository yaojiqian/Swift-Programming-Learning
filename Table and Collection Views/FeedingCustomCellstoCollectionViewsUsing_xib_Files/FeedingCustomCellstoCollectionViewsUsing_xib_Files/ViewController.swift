//
//  ViewController.swift
//  FeedingCustomCellstoCollectionViewsUsing_xib_Files
//
//  Created by Yao Jiqian on 02/08/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    let allImages = [
        UIImage(named: "1"),
        UIImage(named: "2"),
        UIImage(named: "3")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    func randomImage() -> UIImage{
        return allImages[Int(arc4random_uniform(UInt32(allImages.count)))]!
    }

    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout : layout)
        
        let nib = UINib(nibName: "MyCollectionViewCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: "Cell")
        collectionView?.backgroundColor = .white
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width : 80, height : 120)
        
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 20, bottom: 10, right: 20)

        self.init(collectionViewLayout : flowLayout)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Int(3 + arc4random_uniform(UInt32(4)))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(10 + arc4random_uniform(UInt32(6)))
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyCollectionViewCell
        
        cell.imageViewBackgroundImage.image = randomImage()
        cell.imageViewBackgroundImage.contentMode = .scaleAspectFit
        
        return cell
    }
}


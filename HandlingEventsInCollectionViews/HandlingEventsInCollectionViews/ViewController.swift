//
//  ViewController.swift
//  HandlingEventsInCollectionViews
//
//  Created by Yao Jiqian on 19/09/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {
    
    let allImages = [
        UIImage(named: "1"),
        UIImage(named: "2"),
        UIImage(named: "3")
    ]

    let animationDuration : TimeInterval = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        
        let nib = UINib(nibName: "MyCollectionViewCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: "Cell")
        collectionView?.backgroundColor = .white
    }
    
    convenience required init?(coder aDecoder: NSCoder) {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: 80, height: 80)
        
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        self.init(collectionViewLayout: flowLayout)
    }
    
    func randomImage() -> UIImage{
        return allImages[Int(arc4random_uniform(UInt32(allImages.count)))]!
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Int(3 + arc4random_uniform(4))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(5 + arc4random_uniform(3))
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Cell", for: indexPath) as! MyCollectionViewCell
        
        cell.imageViewBackgroundImage.image = randomImage()
        cell.imageViewBackgroundImage.contentMode = .scaleAspectFit
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath) as UICollectionViewCell!
        
        UIView.animate(withDuration: animationDuration, animations: {
            selectedCell?.alpha = 0}, completion: {[weak self](finished: Bool) in UIView.animate(withDuration: self!.animationDuration, animations: {selectedCell?.alpha = 1})})
        
    }
    
    override func collectionView(_ collectionView: UICollectionView, didHighlightItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath) as UICollectionViewCell!
        
        UIView.animate(withDuration: animationDuration, animations: {
            selectedCell?.transform = CGAffineTransform(scaleX: 2, y: 2)
        })
    }
    
    override func collectionView(_ collectionView: UICollectionView, didUnhighlightItemAt indexPath: IndexPath) {
        let selectedCell = collectionView.cellForItem(at: indexPath)
        
        UIView.animate(withDuration: animationDuration, animations: {
            selectedCell?.transform = CGAffineTransform.identity
        })
    }
}


//
//  ViewController.swift
//  AddingCustomInteractionsToCollectionViews
//
//  Created by Yao Jiqian on 20/09/2017.
//  Copyright © 2017 BigBit Corp. All rights reserved.
//

import UIKit

class ViewController: UICollectionViewController {

    let allImages = [
        UIImage(named: "1"),
        UIImage(named: "2"),
        UIImage(named: "3")
    ]
    
    func randomImage() -> UIImage {
        return allImages[Int(arc4random_uniform(UInt32(allImages.count)))]!
    }
    
    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout : layout)
        
        let nib = UINib(nibName: "MyCollectionViewCell", bundle: nil)
        
        collectionView?.register(nib, forCellWithReuseIdentifier: "cell")
        collectionView?.backgroundColor = .white
    }
    
    required convenience init?(coder aDecoder: NSCoder) {
        let flowLayout = UICollectionViewFlowLayout(coder: aDecoder)
        
        flowLayout?.minimumLineSpacing = 20
        flowLayout?.minimumInteritemSpacing = 10
        
        flowLayout?.scrollDirection = .vertical
        flowLayout?.itemSize = CGSize(width: 80, height: 120)
        
        self.init(collectionViewLayout : flowLayout!)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let pinch = UIPinchGestureRecognizer(target: self, action: #selector(handlePinch))
        
        for recognizer in (collectionView?.gestureRecognizers!)!{
            if recognizer is UIPinchGestureRecognizer{
                recognizer.require(toFail: pinch)
            }
        }
        
        collectionView?.addGestureRecognizer(pinch)
    }
    
    func handlePinch(pinch: UIPinchGestureRecognizer){
        let defaultLayoutItemSize = CGSize(width: 80, height: 120)
        let layout = collectionView?.collectionViewLayout as! UICollectionViewFlowLayout
        layout.itemSize =
            CGSize(width: defaultLayoutItemSize.width * pinch.scale,
                   height: defaultLayoutItemSize.height * pinch.scale)
        layout.invalidateLayout()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Int(2 + arc4random_uniform(3))
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(4 + arc4random_uniform(5))
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        
        cell.backgroundImagView.image = randomImage()
        
        return cell
    }
}


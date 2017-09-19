//
//  ViewController.swift
//  ProvidingHeaderAndFooterInaCollectionView
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override init(collectionViewLayout layout: UICollectionViewLayout) {
        super.init(collectionViewLayout: layout)
        
        /* Register the nib with the collection view for easy retrieval */
        let nib = UINib(nibName: "MyCollectionViewCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: "cell")
        
        /* Register the header's nib */
        let headerNib = UINib(nibName: "Header", bundle: nil)
        collectionView?.register(headerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "header")
        
        /* Register the footer's nib */
        let footerNib = UINib(nibName: "Footer", bundle: nil)
        collectionView?.register(footerNib, forSupplementaryViewOfKind: UICollectionElementKindSectionFooter, withReuseIdentifier: "footer")
        
        collectionView?.backgroundColor = .white
        
    }

    required convenience init?(coder aDecoder: NSCoder) {
        let flowLayout = UICollectionViewFlowLayout()
        
        flowLayout.minimumLineSpacing = 20
        flowLayout.minimumInteritemSpacing = 10
        flowLayout.itemSize = CGSize(width: 80, height: 80)
        
        flowLayout.scrollDirection = .vertical
        flowLayout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        
        /* Set the reference size for the header and the footer views */
        flowLayout.headerReferenceSize = CGSize(width: 300, height: 50)
        flowLayout.footerReferenceSize = CGSize(width: 300, height: 50)
        
        self.init(collectionViewLayout : flowLayout)
    }
    
    func randomImage() -> UIImage{
        return allImages[Int(arc4random_uniform(UInt32(allImages.count)))]!
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Int(3 + arc4random_uniform(5))
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Int(2 + arc4random_uniform(4))
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let viewCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! MyCollectionViewCell
        
        viewCell.backgroundImage.image = randomImage()
        
        return viewCell
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        var identifier = "header"
        if kind == UICollectionElementKindSectionFooter{
            identifier = "footer"
        }
        
        let view = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: identifier, for: indexPath)
        if kind == UICollectionElementKindSectionHeader {
            if let header = view as? Header {
                header.label.text = "Header \(indexPath.section + 1)"
            }
        }
        else if kind == UICollectionElementKindSectionFooter {
            if let footer = view as? Footer {
                let t = "Section Footer \(indexPath.section + 1)"
                footer.button.setTitle(t, for: .normal)
            }
        }
        
        return view
    }
}


//
//  CategoryRecipesCell.swift
//  Glutenno
//
//  Created by Nikola Jurkovic on 03/02/2021.
//

import Foundation
import UIKit

class CategoryRecipesCell: UITableViewCell {
    
    @IBOutlet var categoryName: UILabel!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet weak var collectionViewHeightConstraint: NSLayoutConstraint!
  
    var items = [Recipe]() {
        didSet {
            collectionView.reloadData()
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        
    }
    override func layoutSubviews() {
            super.layoutSubviews()
            collectionViewHeightConstraint.constant = collectionView.collectionViewLayout.collectionViewContentSize.height
        }
    
}

class RecipesCell: UICollectionViewCell {
    @IBOutlet var image: UIImageView!
    @IBOutlet var name: UILabel!
    @IBOutlet var time: UILabel!
}

extension CategoryRecipesCell: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 160, height: 180)
    }
}

extension CategoryRecipesCell: UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
}

extension CategoryRecipesCell: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return items.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "RecipesCell", for: indexPath) as! RecipesCell
        let item = items[indexPath.row]
        cell.shadowDecorate()
        cell.image.downloaded(from: item.image)
        cell.name.text = item.name
        cell.time.text = item.duration
        return cell
    }
    
}

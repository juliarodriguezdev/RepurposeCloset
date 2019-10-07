//
//  CategoryCollectionViewCell.swift
//  ClothingManagement
//
//  Created by Julia Rodriguez on 9/9/19.
//  Copyright © 2019 Julia Rodriguez. All rights reserved.
//

import UIKit


class CategoryCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var categoryLabel: UILabel!
        
    @IBOutlet weak var iconImage: UIImageView!
    @IBOutlet weak var quantityLabel: UILabel!
    
    @IBOutlet weak var iconBackgroundView: UIView!
    var category: Category?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateViews()
    }
    
    func updateViews() {
        guard let category = category else { return }
        categoryLabel.text = category.name
        quantityLabel.text = String(category.quantity)
        iconImage.image = category.iconImage
        
    }
}

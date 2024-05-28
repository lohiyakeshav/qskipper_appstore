//
//  FeaturedItemsCollectionViewCell.swift
//  QueueSkipper
//
//  Created by ayush yadav on 20/05/24.
//

import UIKit

class FeaturedItemsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var dishImageLabel: UIImageView!
    
    @IBOutlet var dishNameLabel: UILabel!
    
    
    @IBOutlet var dishRatingLabel: UILabel!
    var dish = Dish()
    
    
    @IBAction func addToCartButtonTapped(_ sender: UIButton) {
        cartDish.append(dish)
    }
    
}

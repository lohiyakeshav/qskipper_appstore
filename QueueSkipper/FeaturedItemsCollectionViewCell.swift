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
    
    
    @IBOutlet var addButton: UIButton!
    
    @IBAction func addToCartButtonTapped(_ sender: UIButton) {
        cartDish.append(dish)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
        
                
        }
    
}

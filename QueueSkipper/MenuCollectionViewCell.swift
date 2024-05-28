//
//  MenuCollectionViewCell.swift
//  QueueSkipper
//
//  Created by ayush yadav on 20/05/24.
//

import UIKit




class MenuCollectionViewCell: UICollectionViewCell {

    
    @IBOutlet var dishImage: UIImageView!
    
    @IBOutlet var dishName: UILabel!
    
    @IBOutlet var dishDescription: UITextView!
    
    @IBOutlet var addToFavourites: UIButton!

    @IBOutlet var addToCart: UIButton!
    
    @IBOutlet var dishRating: UILabel!
    var dish = Dish()
    //var index: Int = 0
    
    @IBAction func addToOrderButtonTapped(_ sender: UIButton) {
       

                addToFavourites.isSelected.toggle()
                //dish.favourites.toggle()
        
        if addToFavourites.isSelected {
                    favouriteDish.append(dish)
                    //addToFavourites.isSelected = true
                    //restaurantSelected.dish[index].favourites = true
                }
                else {
                   // print(dish)
                    
                    favouriteDish.removeAll {$0 == dish}
                    //print(favouriteDish)
                  //addToFavourites.isSelected = false
                    //restaurantSelected.dish[index].favourites = false
                }
            }
    
    @IBAction func addToCartButtonTapped(_ sender: UIButton) {
        cartDish.append(dish)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
        
    }
    
            
    
    
}

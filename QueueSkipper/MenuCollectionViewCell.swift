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
                    print(dish)
                    
                    favouriteDish.removeAll {$0 == dish}
                    print(favouriteDish)
                  //addToFavourites.isSelected = false
                    //restaurantSelected.dish[index].favourites = false
                }
            }
            
    
    
}

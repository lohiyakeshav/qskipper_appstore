//
//  RestaurantListTableViewCell.swift
//  QueueSkipper
//
//  Created by Batch-2 on 16/05/24.
//

import UIKit

class RestaurantListTableViewCell: UITableViewCell {

    @IBOutlet var restaurantImage: UIImageView!
    
    
    @IBOutlet var restaurantName: UILabel!
    
    @IBOutlet var restaurantCuisine: UILabel!
    
    @IBOutlet var restaurantAverageWaitingTime: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    func update(with restaurant: Restaurant) {
        restaurantImage.image = UIImage(named: restaurant.restImage)
        restaurantName.text = restaurant.restName
        restaurantCuisine.text = restaurant.cuisine
        restaurantAverageWaitingTime.text = "\(restaurant.restWaitingTime) Mins"
    }

}

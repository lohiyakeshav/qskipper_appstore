//
//  RestaurantListTableViewCell.swift
//  QueueSkipper
//
//  Created by Batch-2 on 15/05/24.
//

import UIKit

class RestaurantListTableViewCell: UITableViewCell {

    
    
    @IBOutlet var restaurantImage: UIImageView!
    
    
    @IBOutlet weak var restaurantName: UILabel!
    
    
    @IBOutlet weak var restaurantWaitingTime: UILabel!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateRestaurants(with restaurant : Restaurant){
        
        restaurantImage.image = UIImage(named: "\(restaurant.restImage)")
        restaurantName.text = restaurant.restName
        restaurantWaitingTime.text =  "\(restaurant.restWaitingTime) Mins"
        
    }
    
     
}

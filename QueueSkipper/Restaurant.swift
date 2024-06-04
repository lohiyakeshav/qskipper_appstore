//
//  Restaurant.swift
//  QueueSkipper
//
//  Created by Batch-2 on 15/05/24.
//

import Foundation

import UIKit

struct Restaurant: Equatable, Codable{
    var restId: String = ""
    //var restImage : UIImage?
    var restName : String = ""
    var restWaitingTime : Int = 0
    var cuisine : String = ""
    //var dish: [Dish] = []
    var rating: Double = 0.0
    
    static func ==(lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.restName == rhs.restName
    }
    
    enum CodingKeys : String, CodingKey{
        case restId = "_id"
        case restName = "restaurant_Name"
        case restWaitingTime = "estimatedTime"
        case cuisine 
        //case restImage
        
    }
    
}


struct Dish: Equatable, Codable {
    var dishId: String = ""
    var image: String = ""
    var name: String = ""
    var description: String = ""
    var price: Int = 0
    var rating: Double = 0.0
    var foodType: String = ""
    //var favourites: Bool = false
    var restaurant: String = ""
    var availability: Bool = true
    var quantity: Int? 
    
    static func ==(lhs: Dish, rhs: Dish) -> Bool {
        return lhs.dishId == rhs.dishId
    }
    
    enum CodingKeys: String, CodingKey {
        case dishId = "_id"
        case name = "product_name"
        case description
        case price = "product_price"
        case foodType = "food_category"
        case restaurant = "restaurant_id"
        case availability
    }
   
}


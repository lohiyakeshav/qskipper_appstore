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
    var restImage = UIImage(systemName: "photo.on.rectangle")
    var restName : String = ""
    var restWaitingTime : Int = 0
    var cuisine : String = ""
    //var dish: [Dish] = []
    var rating: Double = Double(RestaurantController.shared.formatRating(generateRandomRating())) ?? 4.0
    
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
func generateRandomRating() -> Double {
    return Double.random(in: 3...5)
}


struct Dish: Equatable, Codable {
    var dishId: String = ""
    var image = UIImage(systemName: "photo.on.rectangle")
    var name: String = ""
    var description: String = ""
    var price: Int = 0
    var rating: Double = 0.0
    var foodType: String = ""
    //var favourites: Bool = false
    var restaurant: String = ""
    var availability: Bool = true
    var quantity: Int = 1
    
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
        case rating = "ratinge"
        case quantity
    }
   
}

struct Order: Codable{
    var id: String
    var status: String
    var price: Double
    var items: [Dish]
    var prepTimeRemaining: Int
    var bookingDate: Date
    var scheduledDate: Date?
    var orderSend: Bool?
    var rating: Int?
    
//    enum CodingKeys: String, CodingKey {
//        case id
//    }
}



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
    //var restImage : URL?
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
        case restName = "resturantName"
        case restWaitingTime = "estimatedTime"
        case cuisine = "cuisines"
        //case restImage = "restaurant_photo"
        
    }
}


struct Dish: Equatable, Hashable {
    var dishId: String = ""
    var image: String = ""
    var name: String = ""
    var description: String = ""
    var price: Int = 0
    var rating: Double = 0.0
    var foodType: String = ""
    //var favourites: Bool = false
    var restaurant: String = ""
    var quantity: Int?
    
    static func ==(lhs: Dish, rhs: Dish) -> Bool {
        return lhs.dishId == rhs.dishId
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(dishId)
    }
}


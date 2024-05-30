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
    var restImage : URL?
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
        case restImage
        
    }
}


struct Dish: Equatable {
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
        return lhs.image == rhs.image && lhs.name == rhs.name && lhs.description == rhs.description && lhs.price == rhs.price && lhs.rating == rhs.rating && lhs.foodType == rhs.foodType
    }
}



var restaurant : [Restaurant] = []

var dish: [Dish] = []

var favouriteDish: [Dish] = []

var featuredItem: [Dish] = []

var featuredMenu: [Dish] = []

var cartDish: [Dish] = []

var sectionHeaders: [String] = [ "PRLiveFoods", "Featured Items", "Dishes"]
var homeHeaders: [String] = ["Top Picks", "Restaurants"]

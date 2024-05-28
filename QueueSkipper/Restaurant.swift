//
//  Restaurant.swift
//  QueueSkipper
//
//  Created by Batch-2 on 15/05/24.
//

import Foundation

import UIKit

struct Restaurant: Equatable{
    var restId: String = ""
    var restImage : String = ""
    var restName : String = ""
    var restWaitingTime : Int = 0
    var cuisine : String = ""
    //var dish: [Dish] = []
    var rating: Double = 0.0
    
    static func ==(lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.restName == rhs.restName
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
    
    static func ==(lhs: Dish, rhs: Dish) -> Bool {
        return lhs.image == rhs.image && lhs.name == rhs.name && lhs.description == rhs.description && lhs.price == rhs.price && lhs.rating == rhs.rating && lhs.foodType == rhs.foodType
    }
}



var restaurant : [Restaurant] = [Restaurant(restId: "123", restImage: "big_1", restName: "PR LIVE FOODS", restWaitingTime: 10, cuisine: "Indian", rating: 4.3)]

var dish: [Dish] = []

var favouriteDish: [Dish] = []

var featuredItem: [Dish] = []

var featuredMenu: [Dish] = []

var sectionHeaders: [String] = [ "PRLiveFoods", "Featured Items", "Dishes"]
var homeHeaders: [String] = ["Featured Item", "Restaurants"]

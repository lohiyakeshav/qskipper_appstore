//
//  Restaurant.swift
//  QueueSkipper
//
//  Created by Batch-2 on 15/05/24.
//

import Foundation

import UIKit

struct Restaurant{
    var restImage : String
    var restName : String
    var restWaitingTime : Int
    var cuisine : String
    var dish: [Dish]
    var rating: Double
}

struct RestaurantDetails {
    var cuisine: String = ""
    var ratings: Double = 0.0
    var waitingTime: Int = 0
}

struct FeaturedItem {
    var image: String
    var name: String
    var price: Int
    var foodType: String
}

struct Dish {
    var image: String
    var name: String
    var description: String
    var price: Int
    var rating: Double
    var foodType: String
    var favourites: Bool
}

class Menu {
    static var restaurantDetails = RestaurantDetails()
    static var featuredItems: [FeaturedItem] = []
    static var dish: [Dish] = []
}





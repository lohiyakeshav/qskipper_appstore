//
//  Restaurant.swift
//  QueueSkipper
//
//  Created by Batch-2 on 15/05/24.
//

import Foundation

import UIKit

struct Restaurant: Equatable{
    var restImage : String = ""
    var restName : String = ""
    var restWaitingTime : Int = 0
    var cuisine : String = ""
    var dish: [Dish] = []
    var rating: Double = 0.0
    
    static func ==(lhs: Restaurant, rhs: Restaurant) -> Bool {
        return lhs.restName == rhs.restName
    }
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

struct Dish: Equatable {
    var image: String = ""
    var name: String = ""
    var description: String = ""
    var price: Int = 0
    var rating: Double = 0.0
    var foodType: String = ""
    var favourites: Bool = false
    
    static func ==(lhs: Dish, rhs: Dish) -> Bool {
        return lhs.image == rhs.image && lhs.name == rhs.name && lhs.description == rhs.description && lhs.price == rhs.price && lhs.rating == rhs.rating && lhs.foodType == rhs.foodType
    }
}

var restaurant : [Restaurant] = [
    
    Restaurant(restImage: "big_1", restName: "PR Live Foods", restWaitingTime: 10, cuisine: "North Indian", dish: [Dish(image: "big_2", name: "Samosa", description: "Potato Dish", price: 17, rating: 4.1, foodType: "Veg", favourites: false), Dish(image: "big_3", name: "Bread Pakora", description: "Indian Bread Dish", price: 30, rating: 3.6, foodType: "Veg", favourites: false)], rating: 4.3),
    Restaurant(restImage: "big_2", restName: "Bistro House", restWaitingTime: 10, cuisine: "Fast Food", dish: [Dish(image: "big_3", name: "Pizza", description: "Italian Dish", price: 120, rating: 4.0, foodType: "Veg", favourites: false), Dish(image: "big_1", name: "Omelete", description: "Egg Dish", price: 50, rating: 3.4, foodType: "Non-Veg", favourites: false)], rating: 4.0),
    Restaurant(restImage: "big_3", restName: "Doctor Dosa", restWaitingTime: 10, cuisine: "South Indian", dish: [Dish(image: "big_1", name: "Dosa", description: "South Indian Food", price: 80, rating: 3.9, foodType: "Veg", favourites: false), Dish(image: "big_2", name: "Idli Sambhar", description: "Rice Dish", price: 70, rating: 3.2, foodType: "Veg", favourites: false)], rating: 3.7)
]

var favouriteDish: [Dish] = []



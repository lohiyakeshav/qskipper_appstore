//
//  ResponseModel.swift
//  QueueSkipper
//
//  Created by Batch-2 on 30/05/24.
//

import Foundation
import UIKit

//Response Model to get Restaurants
struct RestaurantsResponse: Codable {
    let restaurants: [Restaurant]
    
    enum CodingKeys: String, CodingKey {
        case restaurants = "Restaurant"
    }
}

//Response Model to get Top Picks
struct TopPicks: Codable {
    let allTopPicks: [Dish]
    
    enum CodingKeys: String, CodingKey {
        case allTopPicks
    }
}

//Response Model to get Dish
struct DishResponse: Codable {
    let products: [Dish]
    
    enum CodingKeys: String, CodingKey {
        case products
    }
}

// Response Model to get Orders
struct OrderResponse: Codable {
    let order: [Order]
    enum CodingKeys: String, CodingKey {
        case order = "all_orders"
    }
}


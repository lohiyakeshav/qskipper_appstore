//
//  MyOrders.swift
//  QueueSkipper
//
//  Created by Batch-2 on 17/05/24.
//

import Foundation


struct Order: Codable{
    var id: String
    var status: String
    var price: Double
    var items: [Dish]
    var prepTimeRemaining: Int
    var bookingDate: Date
    var rating: Int?
    
//    enum CodingKeys: String, CodingKey {
//        case id
//    }
}


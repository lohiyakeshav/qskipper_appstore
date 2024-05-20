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
  
    
}
struct Dish {
    var image: String
    var name: String
    var description: String
    var price: Int
}



//
//  ResponseModel.swift
//  QueueSkipper
//
//  Created by Batch-2 on 30/05/24.
//

import Foundation
import UIKit



struct RestaurantsResponse: Codable {
    let restaurants: [Restaurant]
    
    enum CodingKeys: String, CodingKey {
        case restaurants = "Resturanrt"
    }
}

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
        case restaurants = "Restaurant"
    }
}

struct TopPicks: Codable {
    let allTopPicks: [Dish]
    
    enum CodingKeys: String, CodingKey {
        case allTopPicks
    }
}

struct DishResponse: Codable {
    let products: [Dish]
    
    enum CodingKeys: String, CodingKey {
        case products
    }
}


struct RestaurantImage: Codable {
    let restaurant: Image
    
    enum CodingKeys: String, CodingKey {
        case restaurant
    }
}

struct DishImage: Codable {
    let product_photo: Image
    
    enum CodingKeys: String, CodingKey {
        case product_photo
    }
}

struct Image: Codable {
    let banner_photo64: UIImage
    
    enum CodingKeys: String, CodingKey {
        case banner_photo64
    }
    
    // Custom initializer to decode the UIImage from Base64 string
    init(from decoder: Decoder) throws {
        print("Initialise ho gya")
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let base64String = try container.decode(String.self, forKey: .banner_photo64)
        guard let imageData = Data(base64Encoded: base64String),
              let image = UIImage(data: imageData) else {
            throw DecodingError.dataCorruptedError(forKey: .banner_photo64,in: container,debugDescription: "Image data is corrupted or not in base64 format")
        }
        self.banner_photo64 = image
    }
    
    // Custom function to encode the UIImage as a Base64 string
    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        let imageData = banner_photo64.pngData()
        let base64String = imageData?.base64EncodedString() ?? ""
        try container.encode(base64String, forKey: .banner_photo64)
    }
}

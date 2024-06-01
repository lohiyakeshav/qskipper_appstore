//
//  NetworkUtils.swift
//  QueueSkipper
//
//  Created by Batch-2 on 28/05/24.
//

import Foundation
import UIKit

class NetworkUtils{
    
    var baseURl = URL(string : "https://queueskipperbackend.onrender.com/")!

    static let shared = NetworkUtils()
    
    
    enum NetworkUtilsError : Error, LocalizedError {
    case restaurantNotFound
    case ImageNotFound
//    case restaurantNotFound
//    case restaurantNotFound
    }
    
    func fetchRestaurants() async throws -> [Restaurant]{
        let fetchRestaurantsURL = baseURl.appendingPathComponent("get_All_Restaurant")
        let (data, response) = try await URLSession.shared.data(from: fetchRestaurantsURL)
        
        if let string = String(data: data, encoding: .utf8){
            print(string)
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkUtilsError.restaurantNotFound
        }
        print(httpResponse)
        let decoder = JSONDecoder()
        let restaurantListResponse = try decoder.decode(RestaurantsResponse.self, from: data)
        print(restaurantListResponse)
        return restaurantListResponse.restaurants
    }
    
    func fetchImage(from url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let string = String(data: data, encoding: .utf8){
            print(string)
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 202 else {
            throw NetworkUtilsError.ImageNotFound
        }
        print(httpResponse)
        guard let image = UIImage(data: data) else {
            throw NetworkUtilsError.ImageNotFound
        }
        print(image.size )
        print(image)
        return image
    }
    
}



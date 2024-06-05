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
    case RestaurantNotFound
    case ImageNotFound
    case DishNotFound
//    case restaurantNotFound
    }
    
    func fetchRestaurants() async throws -> [Restaurant]{
        let fetchRestaurantsURL = baseURl.appendingPathComponent("get_All_Restaurant")
        let (data, response) = try await URLSession.shared.data(from: fetchRestaurantsURL)
        
        if let string = String(data: data, encoding: .utf8){
            print(string)
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkUtilsError.RestaurantNotFound
        }
        print(httpResponse)
        let decoder = JSONDecoder()
        let restaurantListResponse = try decoder.decode(RestaurantsResponse.self, from: data)
        print(restaurantListResponse)
        return restaurantListResponse.restaurants
    }
    
    func fetchDish(from url: URL) async throws -> [Dish] {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let string = String(data: data, encoding: .utf8){
            print(string)
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkUtilsError.DishNotFound
        }
        let decoder = JSONDecoder()
        let userResponse = try decoder.decode(DishResponse.self, from: data)
        return userResponse.products

    }
//    
    func fetchImage(from url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let string = String(data: data, encoding: .utf8){
            print(string)
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 202 else {
            throw NetworkUtilsError.ImageNotFound
        }
        let decoder = JSONDecoder()
        let restaurantImage = try decoder.decode(RestaurantImage.self, from: data)
        print("chalagya")
        print(restaurantImage.restaurant.banner_photo64)
        return restaurantImage.restaurant.banner_photo64
    }
    
    func fetchDishImage(from url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let string = String(data: data, encoding: .utf8){
            print(string)
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 202 else {
            throw NetworkUtilsError.ImageNotFound
        }
        let decoder = JSONDecoder()
        let restaurantImage = try decoder.decode(DishImage.self, from: data)
        print("chalagya")
        print(restaurantImage.product_photo.banner_photo64)
        return restaurantImage.product_photo.banner_photo64
    }
    
    func submitOrder(order: Order) async throws {
        let submitOrderURL = baseURl.appendingPathComponent("order-placed")
        var request = URLRequest(url: submitOrderURL)
        print("Order Placed")
        print(order)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(order)
        request.httpBody = jsonData
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let string = String(data: data, encoding: .utf8){
            //print("Order Placed")
            print(string)
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 202 else {
            throw NetworkUtilsError.RestaurantNotFound
        }
        
        
    }
    
}



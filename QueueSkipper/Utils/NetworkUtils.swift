//
//  NetworkUtils.swift
//  QueueSkipper
//
//  Created by Batch-2 on 28/05/24.
//

import Foundation
import UIKit

class NetworkUtils {
    
    var baseURl = URL(string: "https://queueskipperbackend.onrender.com/")!
    
    static let shared = NetworkUtils()
    
    enum NetworkUtilsError: Error, LocalizedError {
        case RestaurantNotFound
        case ImageNotFound
        case DishNotFound
        case RegistrationFailed
        case OTPVerificationFailed
        case LoginFailed
    }
    
    // MARK: - Fetch All Restaurants
    func fetchRestaurants() async throws -> [Restaurant] {
        let fetchRestaurantsURL = baseURl.appendingPathComponent("get_All_Restaurant")
        let (data, response) = try await URLSession.shared.data(from: fetchRestaurantsURL)
        
        if let string = String(data: data, encoding: .utf8) {
            print(string)
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkUtilsError.RestaurantNotFound
        }
        
        let decoder = JSONDecoder()
        let restaurantListResponse = try decoder.decode(RestaurantsResponse.self, from: data)
        return restaurantListResponse.restaurants
    }
    
    // MARK: - Fetch Top Picks
    func fetchTopPicks() async throws -> [Dish] {
        let fetchTopPicksURL = baseURl.appendingPathComponent("top-picks")
        let (data, response) = try await URLSession.shared.data(from: fetchTopPicksURL)
        
        if let string = String(data: data, encoding: .utf8) {
            print(string)
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkUtilsError.RestaurantNotFound
        }
        
        let decoder = JSONDecoder()
        let topPicksResponse = try decoder.decode(TopPicks.self, from: data)
        return topPicksResponse.allTopPicks
    }
    
    // MARK: - Fetch Dish Details
    func fetchDish(from url: URL) async throws -> [Dish] {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let string = String(data: data, encoding: .utf8) {
            print(string)
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkUtilsError.DishNotFound
        }
        
        let decoder = JSONDecoder()
        let dishResponse = try decoder.decode(DishResponse.self, from: data)
        return dishResponse.products
    }
    
    // MARK: - Fetch Image
    func fetchImage(from url: URL) async throws -> UIImage {
        let (data, response) = try await URLSession.shared.data(from: url)
        
        if let string = String(data: data, encoding: .utf8) {
            print(string)
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkUtilsError.ImageNotFound
        }
        
        guard let image = UIImage(data: data) else {
            throw NetworkUtilsError.ImageNotFound
        }
        
        print("Image fetched successfully")
        return image
    }
    
    // MARK: - Submit Order
    func submitOrder(order: Order) async throws {
        let submitOrderURL = baseURl.appendingPathComponent("order-placed")
        var request = URLRequest(url: submitOrderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let jsonEncoder = JSONEncoder()
        request.httpBody = try jsonEncoder.encode(order)
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let string = String(data: data, encoding: .utf8) {
            print(string)
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 202 else {
            throw NetworkUtilsError.RestaurantNotFound
        }
    }
    
    // MARK: - User Registration (OTP Sent)
    func registerUser(email: String, username: String) async throws -> String {
        let registerURL = baseURl.appendingPathComponent("register")
        var request = URLRequest(url: registerURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["email": email, "username": username]
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let string = String(data: data, encoding: .utf8) {
            print(string)
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 202 else {
            throw NetworkUtilsError.RegistrationFailed
        }
        
        return "OTP sent successfully."
    }
    
    // MARK: - OTP Verification
    func verifyUser(email: String, otp: String) async throws -> String {
        let verifyURL = baseURl.appendingPathComponent("verify-register")
        var request = URLRequest(url: verifyURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["email": email, "otp": otp]
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let string = String(data: data, encoding: .utf8) {
            print(string)
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkUtilsError.OTPVerificationFailed
        }
        
        let decodedResponse = try JSONDecoder().decode([String: String].self, from: data)
        return decodedResponse["id"] ?? ""
    }
    
    func verifyLoginUser(email: String, otp: String) async throws -> String {
        let verifyURL = baseURl.appendingPathComponent("verify-login")
        var request = URLRequest(url: verifyURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["email": email, "otp": otp]
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let string = String(data: data, encoding: .utf8) {
            print(string)
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkUtilsError.OTPVerificationFailed
        }
        
        let decodedResponse = try JSONDecoder().decode([String: String].self, from: data)
        return decodedResponse["id"] ?? ""
    }
    
    // MARK: - User Login (OTP Sent)
    func loginUser(email: String) async throws -> (String, String) {
        let loginURL = baseURl.appendingPathComponent("login")
        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["email": email]
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        if let string = String(data: data, encoding: .utf8) {
            print(string)
        }
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 202 else {
            throw NetworkUtilsError.LoginFailed
        }
        
        let decodedResponse = try JSONDecoder().decode([String: String].self, from: data)
        let username = decodedResponse["username"] ?? ""
        let userId = decodedResponse["id"] ?? ""
        
        return (username, userId)
    }
}

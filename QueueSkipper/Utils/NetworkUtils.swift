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

        // Debugging UserDefaults
        if let savedUserId = UserDefaults.standard.string(forKey: "userID") {
            print("✅ User ID Found: \(savedUserId)")
        } else {
            print("❌ User ID Not Found in UserDefaults")
        }

        guard let userId = UserDefaults.standard.string(forKey: "userID"), !userId.isEmpty else {
            throw NSError(domain: "QueueSkipper", code: 401, userInfo: [
                NSLocalizedDescriptionKey: "Bhai ! User ID not found"
            ])
        }

        let requestBody: [String: Any] = [
            "items": order.items.map { dish in
                [
                    "productId": dish.dishId,
                    "name": dish.name,
                    "quantity": dish.quantity,
                    "price": dish.price
                ]
            },
            "price": order.price,
            "restaurant": order.items.first?.restaurant ?? "",
            "userId": userId
        ]

        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody, options: [])

        let (data, response) = try await URLSession.shared.data(for: request)

        // Convert response data to string (if possible)
        guard let responseString = String(data: data, encoding: .utf8) else {
            throw NSError(domain: "QueueSkipper", code: 500, userInfo: [
                NSLocalizedDescriptionKey: "❌ Error: Could not convert response to string"
            ])
        }

        print("📩 Response Data:", responseString)

        // Ensure response is HTTPURLResponse
        guard let httpResponse = response as? HTTPURLResponse else {
            throw NetworkUtilsError.RestaurantNotFound
        }

        // Check for success (Status Code: 200)
        guard httpResponse.statusCode == 200 else {
            print("❌ Error: Unexpected status code:", httpResponse.statusCode)
            throw NSError(domain: "QueueSkipper", code: httpResponse.statusCode, userInfo: [
                NSLocalizedDescriptionKey: "Unexpected status code: \(httpResponse.statusCode)"
            ])
        }

        // ✅ Order ID Extraction
        let orderId = responseString.trimmingCharacters(in: CharacterSet(charactersIn: "\"")) // Remove quotes if present
        print("🎉 Order Placed! Order ID:", orderId)
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
    struct LoginResponse: Decodable {
        let success: Bool
        let message: String
        let username: String
        let id: String
    }

    func loginUser(email: String) async throws -> (String, String) {
        let loginURL = baseURl.appendingPathComponent("login")
        var request = URLRequest(url: loginURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let body: [String: Any] = ["email": email]
        request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])

        do {
            let (data, response) = try await URLSession.shared.data(for: request)

            // Log the raw response for debugging
            if let string = String(data: data, encoding: .utf8) {
                print("📩 Server Response: \(string)")
            }

            // Ensure we received a valid HTTP response with status code 202
            guard let httpResponse = response as? HTTPURLResponse else {
                throw NetworkUtilsError.LoginFailed
            }

            guard httpResponse.statusCode == 202 else {
                print("❌ Login failed. Status code: \(httpResponse.statusCode)")
                throw NSError(domain: "QueueSkipper", code: httpResponse.statusCode, userInfo: [
                    NSLocalizedDescriptionKey: "Login failed with status code: \(httpResponse.statusCode)"
                ])
            }

            // Decode JSON properly
            let decodedResponse = try JSONDecoder().decode(LoginResponse.self, from: data)

            // Print received fields
            print("✅ User: \(decodedResponse.username), ID: \(decodedResponse.id), Message: \(decodedResponse.message)")

            // Store userId in UserDefaults
            UserDefaults.standard.set(decodedResponse.id, forKey: "userID")
            print("✅ User ID \(decodedResponse.id) saved in UserDefaults")

            return (decodedResponse.username, decodedResponse.id)

        } catch {
            print("❌ Error in loginUser: \(error.localizedDescription)")
            throw error
        }
    }


    
//    func placeOrder(order: Order) async throws -> String {
//        let url = NetworkUtils.shared.baseURl.appendingPathComponent("order-placed")
//        
//        let items = order.items.map { dish in
//            [
//                "productId": dish.dishId,
//                "name": dish.name,
//                "quantity": dish.quantity,
//                "price": dish.price
//            ]
//        }
//        
//        guard let userId = UserDefaults.standard.string(forKey: "currentUserId"), !userId.isEmpty else {
//                throw NSError(domain: "User ID not found", code: 401, userInfo: nil)
//            }
//        
//        let requestBody: [String: Any] = [
//            "items": items,
//            "price": order.price,
//            "restaurant": order.items.first?.restaurant ?? "",
//            "userId": userId
//        ]
//        
//        var request = URLRequest(url: url)
//        request.httpMethod = "POST"
//        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
//        request.httpBody = try JSONSerialization.data(withJSONObject: requestBody)
//        
//        let (data, response) = try await URLSession.shared.data(for: request)
//        
//        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
//            throw NetworkUtils.NetworkUtilsError.RestaurantNotFound
//        }
//        
//        let responseData = try JSONDecoder().decode([String: String].self, from: data)
//        return responseData["id"] ?? ""
//    }
    
    func fetchUserOrder(userId: String) async throws -> Order {
        let url = NetworkUtils.shared.baseURl.appendingPathComponent("get-UserOrder/\(userId)")
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET"
        
        let (data, response) = try await URLSession.shared.data(for: request)
        
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw NetworkUtils.NetworkUtilsError.RestaurantNotFound
        }
        
        let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] ?? [:]
        
        let itemsData = jsonResponse["items"] as? [[String: Any]] ?? []
        let items = itemsData.map { item -> Dish in
            Dish(
                dishId: item["productId"] as? String ?? "",
                name: item["name"] as? String ?? "",
                price: item["price"] as? Int ?? 0,
                restaurant: jsonResponse["restaurant"] as? String ?? "", quantity: item["quantity"] as? Int ?? 1
            )
        }
        
        return Order(
            id: jsonResponse["_id"] as? String ?? "",
            status: jsonResponse["status"] as? String ?? "Pending",
            price: jsonResponse["totalAmount"] as? Double ?? 0.0,
            items: items,
            prepTimeRemaining: 0,
            bookingDate: Date(),
            scheduledDate: nil,
            orderSend: nil,
            rating: nil
        )
    }
}

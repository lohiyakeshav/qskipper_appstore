//
//  RestaurantController.swift
//  QueueSkipper
//
//  Created by Batch-2 on 31/05/24.
//

import Foundation
import UIKit

extension Notification.Name {
    static let orderUpdated = Notification.Name("orderUpdated")
}

class RestaurantController {
    
    // Properties for HomeViewController
    private var _restaurant: [Restaurant] = []
    private var _featuredItem: [Dish] = []
    private var _homeHeaders: [String] = ["Top Picks", "Restaurants"]
    
    // Properties for MenuViewController
    private var _dish: [Dish] = []
    private var _featuredMenu: [Dish] = []
    private var _sectionHeaders: [String] = ["PRLiveFoods", "Featured Items", "Dishes"]
    
    // Properties for FavouritesViewController
    private var _favouriteDish: [Dish] = []
    
    // Properties for MyCartViewController
    private var _cartDish: [Dish] = []
    
    // Properties for MyOrdersViewController
    private var _orders: [Order] = []
    
    static let shared = RestaurantController()
    
    // Properties for accessing above private properties
    var restaurant: [Restaurant] { return _restaurant }
    var dish: [Dish] { return _dish }
    var favouriteDish: [Dish] { return _favouriteDish }
    var featuredItem: [Dish] { return _featuredItem }
    var featuredMenu: [Dish] { return _featuredMenu }
    var cartDish: [Dish] { return _cartDish }
    var sectionHeaders: [String] { return _sectionHeaders }
    var homeHeaders: [String] { return _homeHeaders }
    var orders: [Order] { return _orders }
    
    // Function to set properties of HomeViewController
    func setRestaurant(restaurant: [Restaurant]) { _restaurant = restaurant }
    func setRestaurantImage(image: UIImage, index: Int) { _restaurant[index].restImage = image }
    func setFeaturedItem(dish: [Dish]) { _featuredItem = dish }
    
    // Function to set properties of MenuViewController
    func setDishImage(image: UIImage, index: Int) { _dish[index].image = image }
    func appendDish(dish: Dish) { _dish.append(dish) }
    func setDish(dish: [Dish]) { _dish = dish }
    func appendFeaturedMenu(dish: Dish) { _featuredMenu.append(dish) }
    func removeDish() { _dish.removeAll() }
    func removeFeaturedMenu() { _featuredMenu.removeAll() }
    
    // Function to set properties of MyCartViewController
    func appendCartDish(dish: Dish) { _cartDish.append(dish) }
    func setCartDishQuantity(index: Int, quantity: Int) { _cartDish[index].quantity = quantity }
    func removeCartDish(at: Int) { _cartDish.remove(at: at) }
    func removeCartDish() { _cartDish.removeAll() }
    
    // Function to set properties of FavouritesViewController
    func appendFavouriteDish(dish: Dish) { _favouriteDish.append(dish) }
    func removeFavouriteDish(dish: Dish) { _favouriteDish.removeAll { $0.dishId == dish.dishId } }
    
    // Function to set properties of MyOrdersViewController
    func appendOrder(order: Order) {
        _orders.insert(order, at: 0) // Add new orders at the top
        NotificationCenter.default.post(name: .orderUpdated, object: nil)
    }

    func setOrderStatus(status: String, index: Int) {
        guard index < _orders.count else { return }
        _orders[index].status = status
        NotificationCenter.default.post(name: .orderUpdated, object: nil)
    }

    func setOrderSend(orderSend: Bool, index: Int) {
        guard index < _orders.count else { return }
        _orders[index].orderSend = orderSend
        NotificationCenter.default.post(name: .orderUpdated, object: nil)
    }

    func setBookingDate(date: Date, index: Int) {
        guard index < _orders.count else { return }
        _orders[index].bookingDate = date
        NotificationCenter.default.post(name: .orderUpdated, object: nil)
    }

    func setOrderRating(rating: Int, index: Int) {
        guard index < _orders.count else { return }
        _orders[index].rating = rating
        NotificationCenter.default.post(name: .orderUpdated, object: nil)
    }

    func setOrders(_ newOrders: [Order]) {
        _orders = newOrders
        NotificationCenter.default.post(name: .orderUpdated, object: nil)
    }

    func clearOrders() {
        _orders.removeAll()
        NotificationCenter.default.post(name: .orderUpdated, object: nil)
    }

    func formatRating(_ rating: Double) -> String {
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.maximumFractionDigits = 1
        numberFormatter.minimumFractionDigits = 1

        if let formattedRating = numberFormatter.string(from: NSNumber(value: rating)) {
            return formattedRating
        }
        return String(format: "%.1f", rating) // Fallback
    }
}

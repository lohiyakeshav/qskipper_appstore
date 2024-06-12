//
//  RestaurantController.swift
//  QueueSkipper
//
//  Created by Batch-2 on 31/05/24.
//

import Foundation
import UIKit

class RestaurantController {
    
    //Properties for HomeViewController
    private var _restaurant : [Restaurant] = []
    private var _featuredItem: [Dish] = []
    private var _homeHeaders: [String] = ["Top Picks", "Restaurants"]
    
    //Properties for MenuViewController
    private var _dish: [Dish] = []
    private var _featuredMenu: [Dish] = []
    private var _sectionHeaders: [String] = [ "PRLiveFoods", "Featured Items", "Dishes"]
    
    //Properties for FavouritesViewController
    private var _favouriteDish: [Dish] = []
    
    //Properties for MyCartViewController
    private var _cartDish: [Dish] = []
    
    //Properties for MyOrdersViewController
    private var _orders: [Order] = []
    
    static let shared = RestaurantController()
    
    //Properties for accessing above private properties
    var restaurant: [Restaurant] { return _restaurant }
    var dish: [Dish] { return _dish }
    var favouriteDish: [Dish] { return _favouriteDish }
    var featuredItem: [Dish] { return _featuredItem }
    var featuredMenu: [Dish] { return _featuredMenu }
    var cartDish: [Dish] { return _cartDish }
    var sectionHeaders: [String] { return _sectionHeaders }
    var homeHeaders: [String] { return _homeHeaders }
    var orders: [Order] { return _orders }
    
    //function to set properties of HomeViewController
    func setRestaurant(restaurant: [Restaurant]) { _restaurant = restaurant }
    func setRestaurantImage(image: UIImage, index: Int) { _restaurant[index].restImage = image }
    func setFeaturedItem(dish: [Dish]){ _featuredItem = dish }
    
    //function to set properties of MenuViewController
    func setDishImage(image: UIImage, index: Int) { _dish[index].image = image }
    func appendDish(dish: Dish) { _dish.append(dish) }
    func setDish(dish: [Dish]) { _dish = dish}
    func appendFeaturedMenu(dish: Dish) { _featuredMenu.append(dish) }
    func removeDish() { _dish.removeAll() }
    func removeFeaturedMenu() { _featuredMenu.removeAll() }
    
    //function to set properties of MyCartViewController
    func appendCartDish(dish: Dish) { _cartDish.append(dish) }
    func setCartDishQuantity(index: Int, quantity: Int) { _cartDish[index].quantity = quantity }
    func removeCartDish(at: Int) { _cartDish.remove(at: at) }
    func removeCartDish() { _cartDish.removeAll() }
    
    //function to set properties of FavouritesViewController
    func appendFavouriteDish(dish: Dish) { _favouriteDish.append(dish) }
    func removeFavouriteDish(dish: Dish) { _favouriteDish.removeAll{ $0.dishId == dish.dishId } }
    
    //function to set properties of MyOrdersViewController
    func appendOrder(order: Order, index: Int) { _orders.insert(order, at: index) }
    func setOrderStatus(status: String, index: Int) { _orders[index].status = status }
    func setOrderSend(orderSend: Bool, index: Int) { _orders[index].orderSend = orderSend }
    func setBookingDate(date: Date, index: Int) { _orders[index].bookingDate = date }
    func setOrderRating(rating: Int, index: Int) { _orders[index].rating = rating }
    
    //function to convert rating upto one decimal place
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



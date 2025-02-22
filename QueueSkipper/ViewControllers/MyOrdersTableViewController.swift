//
//  MyOrdersTableViewController.swift
//  QueueSkipper
//
//  Created by Batch-2 on 17/05/24.
//

import UIKit

class MyOrdersTableViewController: UITableViewController {
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        self.tabBarItem.title = "My Orders"
        self.tabBarItem.image = UIImage(systemName: "bag")
        self.tabBarItem.selectedImage = UIImage(systemName: "bag.fill")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUserOrders()  // Fetch orders every time the view appears
    }

    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RestaurantController.shared.orders.count
    }
    
    /// Fetches user orders from the API and updates the table view
    private func fetchUserOrders() {
        guard let userId = UserController.shared.getCurrentUserId() else {
            showAlert(message: "No user ID found.")
            return
        }
        
        Task {
            do {
                let fetchedOrders = try await NetworkUtils.shared.fetchUserOrder(userId: userId)

                await MainActor.run {
                   // RestaurantController.shared.clearOrders() // Clear existing orders if method exists
                    RestaurantController.shared.appendOrder(order: fetchedOrders, index: 0) // Append new order(s)
                    tableView.reloadData()
                }
            } catch {
                await MainActor.run {
                    showAlert(message: "Failed to fetch orders: \(error.localizedDescription)")
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrdersTableViewCell
        let order = RestaurantController.shared.orders[indexPath.row]
        
        // Update order status if necessary
        updateOrderStatus(for: order, at: indexPath.row)
        
        // Configure the cell with the order
        cell.configureCell(for: order)
        
        cell.ratingChanged = { rating in
            RestaurantController.shared.setOrderRating(rating: rating, index: indexPath.row)
        }

        return cell
    }

    /// Updates order status dynamically
    private func updateOrderStatus(for order: Order, at index: Int) {
        if order.status == "Preparing" {
            let remainingTime = RestaurantController.shared.orders[index].prepTimeRemaining
            if remainingTime == 0 {
                RestaurantController.shared.setOrderStatus(status: "Completed", index: index)
            }
        }
        
        if order.status == "Scheduled" {
            let dishRemainingTime = RestaurantController.shared.restaurant
                .first { $0.restId == order.items.first?.restaurant }?.restWaitingTime ?? 0
            
            let remainingTime = Calendar.current.dateComponents([.minute], from: Date(), to: order.scheduledDate ?? Date()).minute ?? 0
            if remainingTime <= dishRemainingTime, order.orderSend ?? false == false {
                RestaurantController.shared.setOrderSend(orderSend: true, index: index)
                RestaurantController.shared.setOrderStatus(status: "Preparing", index: index)
                RestaurantController.shared.setBookingDate(date: Date(), index: index)
            }
        }
    }
    
    /// Displays an alert with a given message
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }
}

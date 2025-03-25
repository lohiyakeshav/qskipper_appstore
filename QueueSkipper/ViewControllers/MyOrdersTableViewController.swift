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
        
        // Register for real-time updates
        NotificationCenter.default.addObserver(self, selector: #selector(updateOrders), name: .orderUpdated, object: nil)
    }
    
    @objc private func updateOrders() {
        tableView.reloadData()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchUserOrders()
    }

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RestaurantController.shared.orders.count
    }

    private func fetchUserOrders() {
        guard let userId = UserController.shared.getCurrentUserId() else {
            showAlert(message: "No user ID found.")
            return
        }
        
        Task {
            do {
                let fetchedOrders = try await NetworkUtils.shared.fetchUserOrders(userId: userId)

                print("Fetched Orders:", fetchedOrders)
                await MainActor.run {
                    RestaurantController.shared.setOrders(fetchedOrders)
                }
            } catch {
                print("Error fetching orders:", error.localizedDescription)
                await MainActor.run {
                    showAlert(message: "Failed to fetch orders: \(error.localizedDescription)")
                }
            }
        }
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrdersTableViewCell
        let order = RestaurantController.shared.orders[indexPath.row]
        
        updateOrderStatus(for: order, at: indexPath.row)
        cell.configureCell(for: order)
        
        cell.ratingChanged = { rating in
            RestaurantController.shared.setOrderRating(rating: rating, index: indexPath.row)
        }

        return cell
    }

    private func updateOrderStatus(for order: Order, at index: Int) {
        if order.status == "Preparing" && order.prepTimeRemaining == 0 {
            RestaurantController.shared.setOrderStatus(status: "Completed", index: index)
        }
    }
    
    private func showAlert(message: String) {
        let alert = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        present(alert, animated: true)
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 280
    }

    
}

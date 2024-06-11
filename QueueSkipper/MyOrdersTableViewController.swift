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
       

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.reloadData()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return RestaurantController.shared.orders.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrdersTableViewCell
        if RestaurantController.shared.orders[indexPath.row].status == "Preparing" {
            if cell.calculatePrepTimeRemaining(from: RestaurantController.shared.orders[indexPath.row].bookingDate, prepTime: RestaurantController.shared.orders[indexPath.row].prepTimeRemaining) == 0 {
                RestaurantController.shared.setOrderStatus(status: "Completed", index: indexPath.row)
                
            }
        }
        var dishRemainingTime : Int = 0
        for rest in RestaurantController.shared.restaurant {
            if RestaurantController.shared.orders[indexPath.row].items[0].restaurant == rest.restId {
                dishRemainingTime = rest.restWaitingTime
            }
        }
        if RestaurantController.shared.orders[indexPath.row].status == "Scheduled" {
            let remainingTime = Calendar.current.dateComponents([.minute], from: Date(), to: RestaurantController.shared.orders[indexPath.row].scheduledDate!).minute ?? 0
            if remainingTime <= dishRemainingTime && RestaurantController.shared.orders[indexPath.row].orderSend == false {
                RestaurantController.shared.setOrderSend(orderSend: true, index: indexPath.row)
                RestaurantController.shared.setOrderStatus(status: "Preparing", index: indexPath.row)
                RestaurantController.shared.setBookingDate(date: Date(), index: indexPath.row)
            }
            
        }
        
        let order = RestaurantController.shared.orders[indexPath.row]
        
        cell.configureCell(for: order)
        
        cell.ratingChanged = { rating in
            RestaurantController.shared.setOrderRating(rating: rating, index: indexPath.row) }


//        // Configure the cell...

        return cell
    }
    
   
    
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        280
    }
    
    
    
   

}

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
        loadOrders()

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
        return orders.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "OrderCell", for: indexPath) as! OrdersTableViewCell
        if orders[indexPath.row].status == "Preparing" {
            if cell.calculatePrepTimeRemaining(from: orders[indexPath.row].bookingDate, prepTime: orders[indexPath.row].prepTimeRemaining) == 0 {
                orders[indexPath.row].status = "Completed"
            }
        }
        if orders[indexPath.row].status == "Scheduled" {
            let remainingTime = Calendar.current.dateComponents([.minute], from: Date(), to: orders[indexPath.row].scheduledDate!).minute ?? 0
            if remainingTime <= 30 && orders[indexPath.row].orderSend == false {
                orders[indexPath.row].status = "Preparing"
            }
            
        }
        
        let order = orders[indexPath.row]
        
        cell.configureCell(for: order)
        
        cell.ratingChanged = { rating in orders[indexPath.row].rating = rating }
        
//        cell.OrderIdLabel.text = "Order#\(order.id)"
//        cell.OrderStatus.setTitle("\(order.status)", for: .normal)
//        cell.OrderPriceLabel.text = String(format: " \u{20b9}%.2f", order.price)
//        //cell.OrderItemsLabel.text = order.items.joined(separator: "\n")
//
//
//        let itemDescriptions = order.items.map { "\($0.quantity) x \($0.name)"}
//
//        print(itemDescriptions)
//        cell.OrderItemsLabel.text = itemDescriptions.joined(separator: "\n")
//
//        cell.OrderPrepTimeLabel.text = " \(order.prepTimeRemaining) minutes"
//
//
//
//        let dateFormatter = DateFormatter()
//        dateFormatter.dateStyle = .short
//        dateFormatter.timeStyle = .short
//        cell.OrderBookedLabel.text = dateFormatter.string(from: order.bookingDate)
//
//
//        // Configure the cell...

        return cell
    }
    
    func loadOrders() {
//        let now = Date()
//        orders = [
//            Order(id: "2303", status: "Preparing", price: 374, items: [("Pizza", 2), ("Soda", 3)], prepTimeRemaining: 10, bookingDate: now, rating: nil),
//            Order(id: "2304", status: "Completed", price: 128, items: [("Burger", 3), ("Chai", 1)], prepTimeRemaining: 0, bookingDate: now.addingTimeInterval(-3600), rating: 4),
//            
//            Order(id: "2302", status: "Completed", price: 456, items: [("Panner", 2), ("Naan", 4)], prepTimeRemaining: 0, bookingDate: now.addingTimeInterval(-7200), rating: 1)
//            
//        ]
        tableView.reloadData()
    }
    
 
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        280
    }
    
    
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

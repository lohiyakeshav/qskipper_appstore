//
//  MyOrdersTableViewController.swift
//  QueueSkipper
//
//  Created by Batch-2 on 17/05/24.
//

import UIKit

class MyOrdersTableViewController: UITableViewController {
    
    var orders: [Order] = []

    
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
        
        let order = orders[indexPath.row]
        cell.OrderIdLabel.text = "Order#\(order.id)"
        cell.OrderStatus.setTitle("\(order.status)", for: .normal)
//        var grey = UIColor(red: 211, green: 211, blue: 211, alpha: 1.0)
        if (order.status == "Completed"){
            cell.backgroundColor = .lightGray
            cell.OrderStatus.backgroundColor = .lightGray
            cell.OrderStatus.configuration?.baseForegroundColor = .black
        }
        cell.OrderPriceLabel.text = String(format: " \u{20b9}%.2f", order.price)
        //cell.OrderItemsLabel.text = order.items.joined(separator: "\n")
        
        
        let itemDescriptions = order.items.map { "\($0.quantity) x \($0.name)"}
        
        print(itemDescriptions)
        cell.OrderItemsLabel.text = itemDescriptions.joined(separator: "\n")
        
        cell.OrderPrepTimeLabel.text = " \(order.prepTimeRemaining) minutes"
        
        
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        dateFormatter.timeStyle = .short
        cell.OrderBookedLabel.text = dateFormatter.string(from: order.bookingDate)
        

        // Configure the cell...

        return cell
    }
    
    func loadOrders() {
        let now = Date()
        orders = [
            Order(id: "2303", status: "Preparing", price: 374, items: [("Pizza", 2), ("Soda", 3)], prepTimeRemaining: 10, bookingDate: now),
            Order(id: "2304", status: "Completed", price: 128, items: [("Burger", 3), ("Chai", 1)], prepTimeRemaining: 0, bookingDate: now.addingTimeInterval(-3600)),
            
        ]
        tableView.reloadData()
    }
    

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        270
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

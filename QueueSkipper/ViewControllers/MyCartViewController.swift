//
//  MyCartViewController.swift
//  QueueSkipper
//
//  Created by Vinayak Bansal on 22/05/24.
//

import UIKit
import UserNotifications



class MyCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UNUserNotificationCenterDelegate {
    
    @IBOutlet var orderTimeLabel: UILabel!
    @IBOutlet var convenienceFeeLabel: UILabel!
    @IBOutlet var totalPriceLabel: UILabel!
    @IBOutlet var packMyOrder: UIButton!
    @IBOutlet var scheduleLater: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        updateTotalPrice()
        updateOrderTime()
        reloadTableAndUpdateStepperTags()
        requestNotificationPermission()
        UNUserNotificationCenter.current().delegate = self
        // Do any additional setup after loading the view.
    }
    
    @IBAction func packMyOrderPressed(_ sender: UIButton) {
        packMyOrder.isSelected.toggle()
    }
    @IBAction func scheduleLaterPressed(_ sender: UIButton) {
        scheduleLater.isSelected.toggle()
    }
    
    let convenienceFee = 0.0
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return RestaurantController.shared.cartDish.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCart", for: indexPath) as! MyCartTableViewCell
        
        let item = RestaurantController.shared.cartDish[indexPath.row]
               cell.configure(with: item, index: indexPath.row)
               cell.stepper.tag = indexPath.row // Set tag to identify the row
               
               cell.quantityChanged = { [weak self] quantity in
                   if quantity == 0 {
                       self?.removeItem(at: indexPath.row)
                   } else {
                       RestaurantController.shared.setCartDishQuantity(index: indexPath.row, quantity: quantity)
                       self?.updateTotalPrice()
                       cell.updatePriceLabel(price: Double(item.price), quantity: quantity)
                   }
               }
               
               return cell
           }
    
    @IBOutlet var tableView: UITableView!
    
    @IBAction func payNowButtonTapped(_ sender: UIButton) {
        
        packMyOrder.isSelected = false
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
        var remainingTime : Int = 0
        for rest in RestaurantController.shared.restaurant {
            if RestaurantController.shared.cartDish[0].restaurant == rest.restId {
                remainingTime = rest.restWaitingTime
            }
        }
        
        //when order is scheduled for later
        if scheduleLater.isSelected {
            let scheduledOrder = Order(id: "", status: "Scheduled", price: ordertotalPrice, items: RestaurantController.shared.cartDish, prepTimeRemaining: remainingTime, bookingDate: Date(), scheduledDate: datePickerDate, orderSend: false)
            
            RestaurantController.shared.appendOrder(order: scheduledOrder, index: 0)
            Task {
                    do {
                        if let userId = UserController.shared.getCurrentUserId() {
                            print("User ID: \(userId)") // Debugging Step

                            let jsonData = try JSONEncoder().encode(scheduledOrder)
                            if let jsonString = String(data: jsonData, encoding: .utf8) {
                                print("Scheduled Order JSON: \(jsonString)") // Debugging Step
                            }

                            try await NetworkUtils.shared.submitOrder(order: scheduledOrder)
           
                            
                            print("✅ Scheduled Order Placed Successfully")
                        } else {
                            print("Error: User ID not found")
                        }
                    } catch {
                        print("Error: \(error.localizedDescription)")
                    }
                }
            RestaurantController.shared.removeCartDish()
            tableView.reloadData()
            updateTotalPrice()
            updateOrderTime()
            scheduleLater.isSelected = false
        }
        
        //when order is placed for now
        else {
            let order = (Order(id: "" , status: "Preparing", price: ordertotalPrice, items: RestaurantController.shared.cartDish, prepTimeRemaining: remainingTime, bookingDate: Date(), orderSend: true))
            RestaurantController.shared.appendOrder(order: order, index: 0)
            //Post call for server to send orders placed
            Task {
                    do {
                        if let userId = UserController.shared.getCurrentUserId() {
                            print("User ID: \(userId)") // Debugging Step

                            let jsonData = try JSONEncoder().encode(order)
                            if let jsonString = String(data: jsonData, encoding: .utf8) {
                                print("Order JSON: \(jsonString)") // Debugging Step
                            }

                            try await NetworkUtils.shared.submitOrder(order: order)
                            
                        } else {
                            print("Error: User ID not found")
                        }
                    } catch {
                        print("Error: \(error.localizedDescription)")
                    }
                }


            RestaurantController.shared.removeCartDish()
            tableView.reloadData()
            updateTotalPrice()
            updateOrderTime()
            scheduleOrderPlacedNotification()
        }
    }
    
    
    func requestNotificationPermission() {
           let center = UNUserNotificationCenter.current()
           center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
               if let error = error {
                   print("Error requesting notification permissions: \(error)")
               } else if granted {
                   print("Notification permission granted.")
               } else {
                   print("Notification permission denied.")
               }
           }
       }
    func scheduleOrderPlacedNotification() {
            let content = UNMutableNotificationContent()
            content.title = "Order Placed"
            content.body = "Your order has been placed successfully!"
            content.sound = .default

            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 1, repeats: false)
            let request = UNNotificationRequest(identifier: "orderPlaced", content: content, trigger: trigger)

            let center = UNUserNotificationCenter.current()
            center.add(request) { error in
                if let error = error {
                    print("Error scheduling notification: \(error)")
                } else {
                    print("Notification scheduled.")
                }
            }
        }

    
    
    
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    
    @objc func stepperValueChanged(_ sender: UIStepper) {
        let row = sender.tag
        print(row)// Get the row for which the stepper was changed
        guard row >= 0 && row < RestaurantController.shared.cartDish.count else {
            return
        }
        
        let quantity = Int(sender.value)
        RestaurantController.shared.setCartDishQuantity(index: row, quantity: quantity)
        
        // Update the cell
        if let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? MyCartTableViewCell {
            cell.configure(with: RestaurantController.shared.cartDish[row], index: row)
        }
        
        updateTotalPrice()
        reloadTableAndUpdateStepperTags()
    }
    
    func updateOrderTime() {
            let formatter = DateFormatter()
            formatter.dateFormat = "EEEE, h:mm a"
            let dateString = formatter.string(from: Date())
            orderTimeLabel.text = dateString
        }

    var ordertotalPrice = 0.0
    func updateTotalPrice() {
            var totalPrice = 0.0
        for item in RestaurantController.shared.cartDish {
            totalPrice += Double(item.price) * Double(item.quantity)
            }
            totalPrice += convenienceFee
        ordertotalPrice = totalPrice
            totalPriceLabel.text = String(format: "₹%.2f", totalPrice)
            convenienceFeeLabel.text = String(format: "₹%.2f", convenienceFee)
        }
    
    func removeItem(at index: Int) {
        guard index >= 0 && index < RestaurantController.shared.cartDish.count else {
            return
        }
        RestaurantController.shared.removeCartDish(at: index)
        tableView.performBatchUpdates({
            tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }) { _ in
            self.tableView.reloadData()
            self.updateTotalPrice()
        }
        
        if RestaurantController.shared.cartDish.isEmpty {
            print("Empty Cart")
        }
    }
    
    func reloadTableAndUpdateStepperTags() {
        tableView.reloadData()
        for cell in tableView.visibleCells {
            if let cartCell = cell as? MyCartTableViewCell, let indexPath = tableView.indexPath(for: cartCell) {
                cartCell.stepper.tag = indexPath.row
            }
        }
    }
    
    var datePickerDate = Date()
    
    @IBAction func unwindToMyCart(_ unwindSegue: UIStoryboardSegue) {
        if unwindSegue.identifier == "doneSegue" {
            if let sourceViewController = unwindSegue.source as? PreOrderTableViewController {
                let selectedDate = sourceViewController.scheduleDatePicker.date
                datePickerDate = selectedDate
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "MMM dd, hh:mm a"
                orderTimeLabel.text = dateFormatter.string(from: selectedDate)
            }
        } else {
            scheduleLater.isSelected = false
        }
        
          }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
           completionHandler([.banner, .sound])
       }
       
       func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
           // Handle the notification response
           completionHandler()
       }


}

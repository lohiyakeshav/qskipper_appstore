//
//  MyCartViewController.swift
//  QueueSkipper
//
//  Created by Vinayak Bansal on 22/05/24.
//

import UIKit

class MyCartViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet var orderTimeLabel: UILabel!
    @IBOutlet var convenienceFeeLabel: UILabel!
    
    @IBOutlet var totalPriceLabel: UILabel!
    
    
    @IBOutlet var packMyOrder: UIButton!
    
    
    @IBOutlet var scheduleLater: UIButton!
    
    
    
    
    @IBAction func packMyOrderPressed(_ sender: UIButton) {
//        packMyOrder.image = UIImage(systemName: "circle.fill")
        packMyOrder.isSelected.toggle()
    }
    
    
    @IBAction func scheduleLaterPressed(_ sender: UIButton) {
        scheduleLater.isSelected.toggle()
    }
    
    
    
    let convenienceFee = 0.0
    
    
    
    
//    var cartItems :[(image: UIImage, name: String, price: Double, quantity: Int )] = [
//        
//        (UIImage(named: "big_1")!, "pizza", 321, 1),
//        (UIImage(named: "big_2")!, "burger", 132, 2),
//        (UIImage(named: "big_3")!, "coke", 60, 1),
//        
//        
//    ]

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cartDish.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCart", for: indexPath) as! MyCartTableViewCell
        
        let item = cartDish[indexPath.row]
               cell.configure(with: item, index: indexPath.row)
               cell.stepper.tag = indexPath.row // Set tag to identify the row
               
               cell.quantityChanged = { [weak self] quantity in
                   if quantity == 0 {
                       self?.removeItem(at: indexPath.row)
                   } else {
                       cartDish[indexPath.row].quantity = quantity
                       self?.updateTotalPrice()
                       cell.updatePriceLabel(price: Double(item.price), quantity: quantity)
                   }
               }
               
               return cell
           }
    
    
    
    @IBOutlet var tableView: UITableView!
    
    
    @IBAction func payNowButtonTapped(_ sender: UIButton) {
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: nil)
    }
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.dataSource = self
        tableView.delegate = self
        updateTotalPrice()
        updateOrderTime()
        reloadTableAndUpdateStepperTags()
        // Do any additional setup after loading the view.
    }
    
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        90
    }
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
    
    
    
    @objc func stepperValueChanged(_ sender: UIStepper) {
        let row = sender.tag
        print(row)// Get the row for which the stepper was changed
        guard row >= 0 && row < cartDish.count else {
            return
        }
        
        let quantity = Int(sender.value)
        
        cartDish[row].quantity = quantity
        
        // Update the cell
        if let cell = tableView.cellForRow(at: IndexPath(row: row, section: 0)) as? MyCartTableViewCell {
            cell.configure(with: cartDish[row], index: row)
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

    
    func updateTotalPrice() {
            var totalPrice = 0.0
            for item in cartDish {
                totalPrice += Double(item.price) * Double(item.quantity ?? 1)
            }
            totalPrice += convenienceFee
            totalPriceLabel.text = String(format: "₹%.2f", totalPrice)
            convenienceFeeLabel.text = String(format: "₹%.2f", convenienceFee)
        }
    
    func removeItem(at index: Int) {
        guard index >= 0 && index < cartDish.count else {
            return
        }
        cartDish.remove(at: index)
        tableView.performBatchUpdates({
            tableView.deleteRows(at: [IndexPath(row: index, section: 0)], with: .automatic)
        }) { _ in
            self.tableView.reloadData()
            self.updateTotalPrice()
        }
        
        if cartDish.isEmpty {
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
    
    
    @IBAction func unwindToMyCart(_ unwindSegue: UIStoryboardSegue) {
        if let sourceViewController = unwindSegue.source as? PreOrderTableViewController {
                    let selectedDate = sourceViewController.scheduleDatePicker.date
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "MMM dd, hh:mm a"
                    orderTimeLabel.text = dateFormatter.string(from: selectedDate)
                }
          }


}

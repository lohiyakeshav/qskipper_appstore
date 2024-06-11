//
//  OrdersTableViewCell.swift
//  QueueSkipper
//
//  Created by Batch-2 on 17/05/24.
//

import UIKit

class OrdersTableViewCell: UITableViewCell {
    
    @IBOutlet var OrderIdLabel: UILabel!
    @IBOutlet var OrderPriceLabel: UILabel!
    @IBOutlet var OrderStatus: UIButton!
    @IBOutlet var OrderItemsLabel: UILabel!
    @IBOutlet var OrderPrepTimeLabel: UILabel!
    @IBOutlet var OrderBookedLabel: UILabel!
    
    
    @IBOutlet var starButton1: UIButton!
    @IBOutlet var starButton2: UIButton!
    @IBOutlet var starButton3: UIButton!
    @IBOutlet var starButton4: UIButton!
    @IBOutlet var starButton5: UIButton!
    
    @IBOutlet var scheduledTimeLabel: UILabel!
    
    @IBOutlet var expectedAtLabel: UILabel!
    
    
    var ratingChanged: ((Int) -> Void)?

    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(for order: Order) {
        
        scheduledTimeLabel.isHidden = true
        expectedAtLabel.isHidden = true

        isHighlighted = false

        OrderIdLabel.text = "Order#\(order.id)"
        OrderStatus.setTitle(order.status, for: .normal)
        
      
        
        
        if order.status == "Completed" {
            
            backgroundColor = .systemGray5
            OrderStatus.backgroundColor = .systemGray6
            
            OrderStatus.setTitleColor(.systemGreen, for: .normal)
            OrderStatus.setTitle("Re-Order", for: .normal)
            OrderStatus.configuration?.baseForegroundColor = .black
            OrderPrepTimeLabel.isHidden = true
            showRatingStars()
            
            if let rating = order.rating {
                            updateStars(for: rating)
                        } else {
                            updateStars(for: 0)
                        }
        }
        else if order.status == "Preparing"{
            OrderStatus.backgroundColor = .systemGray6
                        OrderPrepTimeLabel.isHidden = false
                        OrderPrepTimeLabel.text = "\(calculatePrepTimeRemaining(from: order.bookingDate, prepTime: order.prepTimeRemaining)) minutes"
                        hideRatingStars()
                    }
        else {
            scheduledTimeLabel.isHidden = false
            expectedAtLabel.isHidden = false
            let dateFormatter = DateFormatter()
            dateFormatter.dateStyle = .short
            dateFormatter.timeStyle = .short
            scheduledTimeLabel.text = dateFormatter.string(from: order.scheduledDate!)
            OrderStatus.backgroundColor = .systemGray6
                        OrderPrepTimeLabel.isHidden = true
            var dishRemainingTime : Int = 0
            for rest in RestaurantController.shared.restaurant {
                if order.items[0].restaurant == rest.restId {
                    dishRemainingTime = rest.restWaitingTime
                }
            }
            let remainingTime = Calendar.current.dateComponents([.minute], from: Date(), to: order.scheduledDate!).minute ?? 0
            if remainingTime <= dishRemainingTime && order.orderSend == false {
                
                Task.init {
                    try await NetworkUtils.shared.submitOrder(order: order)
                }
            }
            hideRatingStars()
            
        }
            OrderPriceLabel.text = String(format: "₹%.2f", order.price)
        let itemDescriptions = order.items.map { "\(String(describing: $0.quantity)) x \($0.name)" }
                OrderItemsLabel.text = itemDescriptions.joined(separator: "\n")
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateStyle = .short
                dateFormatter.timeStyle = .short
                OrderBookedLabel.text = dateFormatter.string(from: order.bookingDate)
            }
    
    private func hideRatingStars() {
          starButton1.isHidden = true
          starButton2.isHidden = true
          starButton3.isHidden = true
          starButton4.isHidden = true
          starButton5.isHidden = true
      }

      private func showRatingStars() {
          starButton1.isHidden = false
          starButton2.isHidden = false
          starButton3.isHidden = false
          starButton4.isHidden = false
          starButton5.isHidden = false
      }
    
    private func updateStars(for rating: Int) {
        let stars = [starButton1, starButton2, starButton3, starButton4, starButton5]
        for (index, button) in stars.enumerated() {
            if index < rating {
                button?.setImage(UIImage(systemName: "star.fill"), for: .normal)
            } else {
                button?.setImage(UIImage(systemName: "star"), for: .normal)
            }
        }
    }
    
    @IBAction func starButtonTapped(_ sender: UIButton) {
            let rating = sender.tag
            updateStars(for: rating)
            ratingChanged?(rating)
        }
    
    func calculatePrepTimeRemaining(from bookingDate: Date, prepTime: Int) -> Int {
           let currentTime = Date()
           let elapsedTime = Calendar.current.dateComponents([.minute], from: bookingDate, to: currentTime).minute ?? 0
           let remainingTime = max(0, prepTime - elapsedTime)
           return remainingTime
       }
        
        
            
}
        
    
    



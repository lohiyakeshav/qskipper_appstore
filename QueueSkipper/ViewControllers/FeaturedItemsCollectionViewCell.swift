//
//  FeaturedItemsCollectionViewCell.swift
//  QueueSkipper
//
//  Created by ayush yadav on 20/05/24.
//

import UIKit

class FeaturedItemsCollectionViewCell: UICollectionViewCell {
    
    // Outlets to show the FeaturedItems in MenuViewController
    @IBOutlet var dishImageLabel: UIImageView!
    @IBOutlet var dishNameLabel: UILabel!
    @IBOutlet var dishRatingLabel: UILabel!
    @IBOutlet var addButton: UIButton!
    
    var dish = Dish() {
        didSet {
            updateAddButtonState()
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateAddButtonState()
        NotificationCenter.default.addObserver(self, selector: #selector(cartUpdated), name: .cartUpdated, object: nil)
        }
    deinit {
            NotificationCenter.default.removeObserver(self, name: .cartUpdated, object: nil)
        }
    
    @IBAction func addToCartButtonTapped(_ sender: UIButton) {
        dish.quantity = 1
        RestaurantController.shared.appendCartDish(dish: dish)
        self.contentView.bringSubviewToFront(addButton)
                    
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: { _ in
            
            self.updateAddButtonState()
            
            NotificationCenter.default.post(name: .cartUpdated, object: nil)
        })
    }
    
    //function to update the state of add button
    func updateAddButtonState() {
        if RestaurantController.shared.cartDish.contains(where: { $0.dishId == dish.dishId }) {
                addButton.isEnabled = false
                addButton.setTitle("In Cart", for: .normal)
                addButton.alpha = 0.5
            } else {
                addButton.isEnabled = true
                addButton.setTitle("ADD", for: .normal)
                addButton.alpha = 1.0
            }
        }
        @objc func cartUpdated() {
            updateAddButtonState()
        }
    
}
extension Notification.Name {
    static let cartUpdated = Notification.Name("cartUpdated")
}



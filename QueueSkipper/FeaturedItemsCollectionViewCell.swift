//
//  FeaturedItemsCollectionViewCell.swift
//  QueueSkipper
//
//  Created by ayush yadav on 20/05/24.
//

import UIKit

class FeaturedItemsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var dishImageLabel: UIImageView!
    
    @IBOutlet var dishNameLabel: UILabel!
    
    
    @IBOutlet var dishRatingLabel: UILabel!
    var dish = Dish() {
        didSet {
            updateAddButtonVisibility()
        }
    }
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        updateAddButtonVisibility()
            
            
        NotificationCenter.default.addObserver(self, selector: #selector(cartUpdated), name: .cartUpdated, object: nil)
        }
    
    deinit {
            NotificationCenter.default.removeObserver(self, name: .cartUpdated, object: nil)
        }

    
    @IBOutlet var addButton: UIButton!
    
    @IBAction func addToCartButtonTapped(_ sender: UIButton) {
        
        cartDish.append(dish)
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: [], animations: {
            sender.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
            sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        }, completion: { _ in
            self.updateAddButtonVisibility()
            NotificationCenter.default.post(name: .cartUpdated, object: nil)
        })
    }
    
    
    func updateAddButtonVisibility() {
            if cartDish.contains(where: { $0.dishId == dish.dishId }) {
                addButton.isHidden = true
            } else {
                addButton.isHidden = false
            }
        }
        
        @objc func cartUpdated() {
            updateAddButtonVisibility()
        }
    
}
extension Notification.Name {
    static let cartUpdated = Notification.Name("cartUpdated")
}



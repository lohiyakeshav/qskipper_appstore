import UIKit

class MenuCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet var dishImage: UIImageView!
    @IBOutlet var dishName: UILabel!
    @IBOutlet var dishDescription: UITextView!
    @IBOutlet var addToFavourites: UIButton!
    @IBOutlet var addToCart: UIButton!
    @IBOutlet var dishRating: UILabel!

    @IBOutlet var foodCategoryLabel: UILabel!
    
    @IBOutlet var foodCategoryLabel2: UILabel!
    
    
    
    @IBOutlet var dishPriceLabel: UILabel!
    
    
    var dish = Dish()
    {
        didSet {
            updateFavouriteButtonState()
            updateCartButtonState()
        }
    }

    @IBAction func addToFavouritesTapped(_ sender: UIButton) {
        if addToFavourites.isSelected {
            RestaurantController.shared.removeFavouriteDish(dish: dish)
        } else {
            RestaurantController.shared.appendFavouriteDish(dish: dish)
        }
        NotificationCenter.default.post(name: .favouritesUpdated, object: nil)
        updateFavouriteButtonState()
    }
    
    @IBAction func addToCartButtonTapped(_ sender: UIButton) {
        dish.quantity = 1
        RestaurantController.shared.appendCartDish(dish: dish)
        NotificationCenter.default.post(name: .cartUpdated, object: nil)
        
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 0.7, initialSpringVelocity: 0.1, options: [], animations: {
                    sender.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                    sender.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }, completion: { _ in
                    // Disable the button and change its text after the animation
                    self.updateCartButtonState()
                    
                    NotificationCenter.default.post(name: .cartUpdated, object: nil)
                })
//        NotificationCenter.default.post(name: .cartUpdated, object: nil)
        
        
        
        
    }
    
    private func updateFavouriteButtonState() {
        let isFavourite = RestaurantController.shared.favouriteDish.contains(where: { $0.dishId == dish.dishId })
        addToFavourites.isSelected = isFavourite
    }
    
     private func updateCartButtonState() {
        let isInCart = RestaurantController.shared.cartDish.contains(where: { $0 == dish })
                if isInCart {
                    addToCart.isEnabled = false
                    addToCart.setTitle("In Cart", for: .normal)
                    addToCart.alpha = 0.5 // Optionally, adjust the appearance to indicate it's disabled
                } else {
                    addToCart.isEnabled = true
                    addToCart.setTitle("ADD", for: .normal)
                    addToCart.alpha = 1.0
                }
            }
}

extension Notification.Name {
    static let favouritesUpdated = Notification.Name("favouritesUpdated")
    //static let cartUpdate = Notification.Name("cartUpdated")
}

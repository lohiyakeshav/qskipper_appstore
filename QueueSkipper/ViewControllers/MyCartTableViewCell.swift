//
//  MyCartTableViewCell.swift
//  QueueSkipper
//
//  Created by Vinayak Bansal on 24/05/24.
//

import UIKit

class MyCartTableViewCell: UITableViewCell {

 
    @IBOutlet var dishQuantity: UILabel!
    @IBOutlet var cartFoodImage: UIImageView!
    @IBOutlet var cartDishName: UILabel!
    @IBOutlet var dishPrice: UILabel!
    @IBOutlet var stepper: UIStepper!
    
    var quantityChanged: ((Int) -> Void)?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        stepper.addTarget(self, action: #selector(stepperValueChanged(_:)), for: .valueChanged)
      
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configure(with item: Dish,index: Int) {
        cartFoodImage.image = item.image
           cartDishName.text = item.name
        dishQuantity.text = "\(item.quantity)"
        updatePriceLabel(price: Double(item.price), quantity: item.quantity)
        stepper.value = Double(item.quantity)
        print(stepper.value)
           stepper.tag = index
       }
       
       @objc func stepperValueChanged(_ sender: UIStepper) {
           let quantity = Int(sender.value)
           dishQuantity.text = "\(quantity)"
           quantityChanged?(quantity)
    
           
       }
       
        func updatePriceLabel(price: Double, quantity: Int) {
           let totalPrice = price * Double(quantity)
           dishPrice.text = "Price: \(totalPrice)"
       }
    

}

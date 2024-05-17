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
    
    
    
    

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

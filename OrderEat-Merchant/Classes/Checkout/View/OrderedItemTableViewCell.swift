//
//  OrderedItemTableViewCell.swift
//  OrderEat-Merchant
//
//  Created by Gregory Kevin on 14/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class OrderedItemTableViewCell: UITableViewCell {

    @IBOutlet weak var itemImageView: UIImageView!
    @IBOutlet weak var itemNameLabel: UILabel!
    @IBOutlet weak var itemQtyLabel: UILabel!
    @IBOutlet weak var itemPriceLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var detail : TransactionDetail! {
        didSet {
            let menu = detail.menu!
            
            self.itemImageView.image = UIImage(named: "Blackpepper Burger.png")
            self.itemNameLabel.text = menu.name
            self.itemQtyLabel.text = String(detail.qty!)
            self.itemPriceLabel.text = "Rp. \(menu.price!)"
        }
    }

}

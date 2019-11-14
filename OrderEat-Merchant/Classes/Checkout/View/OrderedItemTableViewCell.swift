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
    @IBOutlet weak var itemStatusLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }
    
    func config() {
        self.itemStatusLabel.textColor = .orangeTextColor
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    var data: Menu! {
        didSet {
            self.itemImageView.image = UIImage(named: "Blackpepper Burger.png")
            self.itemNameLabel.text = data.name
            self.itemQtyLabel.text = "2"
            self.itemPriceLabel.text = "\(data.price!)"
            self.itemStatusLabel.text = "Waiting for payment"
        }
    }

}

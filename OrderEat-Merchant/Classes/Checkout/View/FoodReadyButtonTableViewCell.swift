//
//  FoodReadyButtonTableViewCell.swift
//  OrderEat-Merchant
//
//  Created by Gregory Kevin on 14/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class FoodReadyButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var foodReadyButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        config()
        
    }
    
    func config() {
        self.foodReadyButton.backgroundColor = .ijoDela
        self.foodReadyButton.setTitleColor(.black, for: .normal)
        self.foodReadyButton.setTitle("Food Ready", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

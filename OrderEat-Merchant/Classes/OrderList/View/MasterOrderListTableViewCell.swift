//
//  MasterOrderListTableViewCell.swift
//  OrderEat-Merchant
//
//  Created by Malvin Santoso on 15/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class MasterOrderListTableViewCell: UITableViewCell {
    @IBOutlet weak var tipeLabel: UILabel!
    var accessoryBadge = UILabel()
    var transactionCount : Int! {
        didSet {
            self.accessoryBadge.text = String(transactionCount)
        }
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        
        accessoryBadge.textColor = .black
        accessoryBadge.backgroundColor = #colorLiteral(red: 0.8588235294, green: 0.8941176471, blue: 0.4392156863, alpha: 1)
        accessoryBadge.font = accessoryBadge.font.withSize(17)
        accessoryBadge.textAlignment = .center
        accessoryBadge.layer.cornerRadius = 15
        accessoryBadge.clipsToBounds = true
        
        accessoryBadge.frame = CGRect(x: 0, y: 0, width: 30, height: 30)

        self.accessoryView = accessoryBadge
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        if selected {
            backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.5215686275, blue: 0.1294117647, alpha: 1)
            tipeLabel.textColor = .white
        }
        else {
            backgroundColor = .white
            tipeLabel.textColor = .black
        }
    }
}

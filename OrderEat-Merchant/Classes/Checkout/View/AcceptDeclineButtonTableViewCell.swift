//
//  AcceptDeclineButtonTableViewCell.swift
//  OrderEat-Merchant
//
//  Created by Gregory Kevin on 14/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class AcceptDeclineButtonTableViewCell: UITableViewCell {

    @IBOutlet weak var declineButton: UIButton!
    @IBOutlet weak var acceptButton: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        config()
    }
    
    func config() {
        declineButton.setTitleColor(.black, for: .normal)
        declineButton.setTitle("Decline", for: .normal)
        
        acceptButton.setTitleColor(.black, for: .normal)
        acceptButton.backgroundColor = .ijoDela
        acceptButton.setTitle("Accept", for: .normal)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}

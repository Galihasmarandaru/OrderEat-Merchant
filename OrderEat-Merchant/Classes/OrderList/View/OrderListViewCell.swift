//
//  OrderListViewCell.swift
//  OrderEat-Merchant
//
//  Created by Malvin Santoso on 14/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class OrderListViewCell: UITableViewCell {
    @IBOutlet weak var orderNo: UILabel!
    @IBOutlet weak var pickUpTime: UILabel!
    @IBOutlet weak var customerDetails: UILabel!
    @IBOutlet weak var orderPrice: UILabel!
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var foodisReadyButton: UIButton!
    
    var foodReadyClosure : (() -> ())?
    
    var transaction: Transaction! {
        didSet {
            let customerName = transaction.customer!.name!
            let customerPhone = transaction.customer!.phone!
            self.customerDetails.text = "\(customerName) - \(customerPhone)"
            self.orderStatus.text = transactionStatus[transaction.status!]
            
            let price = transaction.total!
            self.orderPrice.text = "Rp. \(price)"
            
            self.pickUpTime.text = transaction.pickUpTime!.time
        }
    }
    
    @IBAction func acceptBtnPressed(_ sender: Any) {
        let parameter = ["status" : 1]
        APIRequest.put(.transactions, id: transaction.id!, parameter: parameter)
    }
    
    @IBAction func foodReadyBtnPressed(_ sender: UIButton) {
        let parameter = ["status" : 3]
        APIRequest.put(.transactions, id: transaction.id!, parameter: parameter)
        
        foodReadyClosure?()
    }
}



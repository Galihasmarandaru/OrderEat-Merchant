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
    @IBOutlet weak var orderDate: UILabel!
    @IBOutlet weak var orderStatus: UILabel!
    @IBOutlet weak var foodisReadyButton: UIButton!
    var foodReadyClosure : (() -> ())?
    var warna:[UIColor] = [#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.9372549057, green: 0.3490196168, blue: 0.1921568662, alpha: 1),#colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1),#colorLiteral(red: 0.3411764801, green: 0.6235294342, blue: 0.1686274558, alpha: 1),.black,.red,.red]
    var transaction: Transaction! {
        didSet {
            let customerName = transaction.customer!.name!
            let customerPhone = transaction.customer!.phone!
            let price = transaction.total!
            self.customerDetails.text = "\(customerName) - \(customerPhone)      Rp. \(price)"
            self.orderStatus.text = transactionStatus[transaction.status!]
            self.orderStatus.textColor = warna[transaction.status!]
            self.pickUpTime.text = "Pick Up Time : \(transaction.pickUpTime!.time)"
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




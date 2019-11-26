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
    var warna:[UIColor] = [.black,.red,.blue,.green,.orange,.yellow,.cyan]
    var transaction: Transaction! {
        didSet {
            let customerName = transaction.customer!.name!
            let customerPhone = transaction.customer!.phone!
            self.customerDetails.text = "\(customerName) - \(customerPhone)"
            self.orderStatus.text = transactionStatus[transaction.status!]
            let price = transaction.total!
            self.orderPrice.text = "Rp. \(price)"
            self.orderStatus.textColor = warna[transaction.status!]
            self.pickUpTime.text = transaction.pickUpTime!.time
        }
    }
    func warnaStatus(){
        if transaction.status == 0{
            self.orderStatus.textColor = .red
        }else if transaction.status == 1{
            self.orderStatus.textColor = .blue
        }else if transaction.status == 2{
            self.orderStatus.textColor = .green
        }else if transaction.status == 3{
            self.orderStatus.textColor = .orange
        }else if transaction.status == 4{
            self.orderStatus.textColor = .yellow
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




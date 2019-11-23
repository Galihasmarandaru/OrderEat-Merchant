//
//  CheckoutViewController.swift
//  OrderEat-Merchant
//
//  Created by Gregory Kevin on 14/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class CheckoutViewController: UIViewController {

    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var orderNoAndPickUpTimeLabel: UILabel!
    @IBOutlet weak var nameAndPhoneLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var checkoutTableView: UITableView!
    
    var orderNumber = "D-01"
    
    var transaction : Transaction!
    
    var details : [TransactionDetail] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.config()
        self.initTransaction()
    }
    
    func initTransaction() {
        let customerName = transaction.customer!.name!
        let customerPhone = transaction.customer!.phone!
        nameAndPhoneLabel.text = "\(customerName) - \(customerPhone)"
       
        orderNoAndPickUpTimeLabel.text = "\(orderNumber) | \(transaction.pickUpTime!.time)"
        dateLabel.text = "Date"
       
        details = transaction.details!
    }
    
    func config() {
        self.view.backgroundColor = .systemGray6
        self.headerView.layer.masksToBounds = true
        self.headerView.layer.cornerRadius = 15
        checkoutTableView.tableFooterView = UIView()
    }
    
    @IBAction func acceptBtnPressed(_ sender: Any) {
        let parameter = ["status" : 1]
        APIRequest.put(.transactions, id: transaction.id!, parameter: parameter)
    }
    
    @IBAction func declineBtnPressed(_ sender: Any) {
        let parameter = ["status" : 6]
        APIRequest.put(.transactions, id: transaction.id!, parameter: parameter)
    }
    
    @IBAction func foodReadyButtonClicked(_ sender: Any) {
        // do something is food ready button is clicked
        Alert.showBasicAlert(on: self, with: "Confirm Process", message: "Are you sure Order No: " + orderNumber + " is done and ready to be picked up?", yesAction: {
            let parameter = ["status" : 3]
            APIRequest.put(.transactions, id: self.transaction.id!, parameter: parameter)
        })
    }
    
    func alertActionYesClicked() {
        
    }
}

extension CheckoutViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let status = transaction.status!
        if status == 0 || status == 2 {
            return details.count + 5
        }
        else {
            return details.count + 4
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < details.count {
            let cellFood = tableView.dequeueReusableCell(withIdentifier: "orderedItemTableViewCell", for: indexPath) as! OrderedItemTableViewCell
            
            cellFood.detail = details[indexPath.row]
            
            return cellFood
        }
        else if indexPath.row == details.count {
            let cellSub = tableView.dequeueReusableCell(withIdentifier: "priceDetailsTableViewCell", for: indexPath) as! PriceDetailsTableViewCell
            cellSub.leftLabel.text = "Subtotal"
            cellSub.rightLabel.text = "Rp. \(transaction.getSubTotalPrice())"
            
            return cellSub
        }
        else if indexPath.row == details.count + 1 {
            let cellTax = tableView.dequeueReusableCell(withIdentifier: "priceDetailsTableViewCell", for: indexPath) as! PriceDetailsTableViewCell
            cellTax.leftLabel.text = "Tax"
            cellTax.rightLabel.text = "Rp. \(transaction.getTaxPrice())"
            
            return cellTax
        }
        else if indexPath.row == details.count + 2 {
            let cellTotal = tableView.dequeueReusableCell(withIdentifier: "priceDetailsTableViewCell", for: indexPath) as! PriceDetailsTableViewCell
            cellTotal.leftLabel.text = "Total"
            cellTotal.rightLabel.text = "Rp. \(transaction.total!)"
            
            return cellTotal
        }
        else if indexPath.row == details.count + 3 {
            let cellPickup = tableView.dequeueReusableCell(withIdentifier: "pickUpAndPaymentTableViewCell", for: indexPath) as! PickUpAndPaymentTableViewCell
            
            cellPickup.leftLabel.text = "Pick Up Time"
            cellPickup.rightLabel.text = "\(transaction.pickUpTime!.time)"
            
            return cellPickup
        }
//        else if indexPath.row == details.count + 4 {
//            let cellPickup = tableView.dequeueReusableCell(withIdentifier: "pickUpAndPaymentTableViewCell", for: indexPath) as! PickUpAndPaymentTableViewCell
//
//            cellPickup.leftLabel.text = "Payment Method"
//            cellPickup.rightLabel.text = "GOPAY"
//            cellPickup.leftLabel.isHidden = false
//            cellPickup.rightLabel.isHidden = false
//
//            return cellPickup
//        }
        else {
            let status = transaction.status!
            
            if status == 0 {
                let cellButton = tableView.dequeueReusableCell(withIdentifier: "acceptDeclineButtonTableViewCell", for: indexPath) as! AcceptDeclineButtonTableViewCell
                
                return cellButton
            }
            else if status == 1 {
                let cellButton = tableView.dequeueReusableCell(withIdentifier: "pickUpAndPaymentTableViewCell", for: indexPath) as! PickUpAndPaymentTableViewCell
                
                cellButton.leftLabel.isHidden = true
                cellButton.rightLabel.isHidden = true
                
                return cellButton
            }
            else if status == 2 {
                let cellButton = tableView.dequeueReusableCell(withIdentifier: "foodReadyButtonTableViewCell", for: indexPath) as! FoodReadyButtonTableViewCell
                
                return cellButton
            }
            else {
                let cellButton = tableView.dequeueReusableCell(withIdentifier: "pickUpAndPaymentTableViewCell", for: indexPath) as! PickUpAndPaymentTableViewCell
                
                cellButton.leftLabel.isHidden = true
                cellButton.rightLabel.isHidden = true
                
                return cellButton
            }
        }
    }
}


/*
 // accept function
 let parameter = ["status" : 1]
 APIRequest.put(.transactions, id: transaction.id!, parameter: parameter)
 
 // decline function
 let parameter = ["status" : 6]
 APIRequest.put(.transactions, id: transaction.id!, parameter: parameter)
 
 // food ready function
 let parameter = ["status" : 3]
 APIRequest.put(.transactions, id: transaction.id!, parameter: parameter)
 
 // complete function
 let parameter = ["status" : 4]
 APIRequest.put(.transactions, id: transaction.id!, parameter: parameter)
 
 */

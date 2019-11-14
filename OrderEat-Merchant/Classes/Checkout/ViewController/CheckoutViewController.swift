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
    
    var status = 3
    
    var foods = CheckoutViewModel.getDataMenuTransaction()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.config()
    }
    
    func config() {
        self.view.backgroundColor = .systemGray6
        self.headerView.layer.masksToBounds = true
        self.headerView.layer.cornerRadius = 15
        checkoutTableView.tableFooterView = UIView()
    }
    
    @IBAction func declineButtonClicked(_ sender: Any) {
        // do something is decline button is clicked
    }
    
    @IBAction func acceptButtonClicked(_ sender: Any) {
        // do something is accept button is clicked
    }
    
    @IBAction func foodReadyButtonClicked(_ sender: Any) {
        // do something is food ready button is clicked
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

extension CheckoutViewController: UITableViewDataSource, UITableViewDelegate {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return foods.count + 6
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row < foods.count {
            let cellFood = tableView.dequeueReusableCell(withIdentifier: "orderedItemTableViewCell", for: indexPath) as! OrderedItemTableViewCell
            
            cellFood.data = foods[indexPath.row]
            
            return cellFood
        }
        else if indexPath.row == foods.count {
            let cellSub = tableView.dequeueReusableCell(withIdentifier: "priceDetailsTableViewCell", for: indexPath) as! PriceDetailsTableViewCell
            cellSub.leftLabel.text = "Subtotal"
            cellSub.rightLabel.text = "Rp. 130.000"
            
            return cellSub
        }
        else if indexPath.row == foods.count + 1 {
            let cellTax = tableView.dequeueReusableCell(withIdentifier: "priceDetailsTableViewCell", for: indexPath) as! PriceDetailsTableViewCell
            cellTax.leftLabel.text = "Tax"
            cellTax.rightLabel.text = "Rp. 13.000"
            
            return cellTax
        }
        else if indexPath.row == foods.count + 2 {
            let cellTotal = tableView.dequeueReusableCell(withIdentifier: "priceDetailsTableViewCell", for: indexPath) as! PriceDetailsTableViewCell
            cellTotal.leftLabel.text = "Total"
            cellTotal.rightLabel.text = "Rp. 143.000"
            
            return cellTotal
        }
        else if indexPath.row == foods.count + 3 {
            let cellPickup = tableView.dequeueReusableCell(withIdentifier: "pickUpAndPaymentTableViewCell", for: indexPath) as! PickUpAndPaymentTableViewCell
            
            cellPickup.leftLabel.text = "Pick Up Time"
            cellPickup.rightLabel.text = "12.00"
            cellPickup.leftLabel.isHidden = false
            cellPickup.rightLabel.isHidden = false
            
            return cellPickup
        }
        else if indexPath.row == foods.count + 4 {
            let cellPickup = tableView.dequeueReusableCell(withIdentifier: "pickUpAndPaymentTableViewCell", for: indexPath) as! PickUpAndPaymentTableViewCell
            
            cellPickup.leftLabel.text = "Payment Method"
            cellPickup.rightLabel.text = "GOPAY"
            cellPickup.leftLabel.isHidden = false
            cellPickup.rightLabel.isHidden = false
            
            return cellPickup
        }
        else {
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

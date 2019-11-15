//
//  OrderListViewController.swift
//  OrderEat-Merchant
//
//  Created by Malvin Santoso on 14/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class OrderListViewController: UIViewController {

    @IBOutlet weak var detailsTableView: UITableView!
    
    var isiCell = OrderListViewModel.getTransaction()
    var color : UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Add", style: .plain, target: self, action: nil)
        // Do any additional setup after loading the view.
      
        detailsTableView.backgroundColor = color
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

extension OrderListViewController: UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return isiCell.count
        
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrderListViewCell
        
        cell.orderNo.text = isiCell[indexPath.row].id
        cell.pickUpTime.text = isiCell[indexPath.row].pickUpTime
        cell.customerDetails.text = isiCell[indexPath.row].customerId
        cell.orderPrice.text = "\(isiCell[indexPath.row].total!)"
        cell.orderDate.text = "29 Oktober 2019"
        cell.orderStatus.text = "\(isiCell[indexPath.row].status!)"
        if isiCell[indexPath.row].status == 3{
            cell.foodisReadyButton.isHidden = false
        }else {
            cell.foodisReadyButton.isHidden = true
        }

        return cell
    }
    
    
    
    
}

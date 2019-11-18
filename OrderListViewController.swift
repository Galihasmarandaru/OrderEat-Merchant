//
//  OrderListViewController.swift
//  OrderEat-Merchant
//
//  Created by Malvin Santoso on 14/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class OrderListViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate{

    @IBOutlet weak var detailsTableView: UITableView!
    
    var isiCell = OrderListViewModel.getTransaction()
    var color : UIColor!
    let cellSpacingHeight: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Scan QR "), style: .plain, target: self, action:#selector(openCamera))
        // Do any additional setup after loading the view.
      
        detailsTableView.backgroundColor = color
    }
    
    @objc func openCamera(){
//        let storyboard = UIStoryboard(name: "OrderList", bundle: nil)
//        let qrScanPage = storyboard.instantiateViewController(identifier: "QRCodeScannerViewController") as! QRCodeScannerViewController
//        let appDelegate = UIApplication.shared.windows
//        appDelegate.first?.rootViewController = qrScanPage
        
        performSegue(withIdentifier: "push", sender: nil)
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

    func numberOfSections(in tableView: UITableView) -> Int {
           return isiCell.count
       }

       // There is just one row in every section
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return 1
       }

       // Set the spacing between sections
       func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
           return cellSpacingHeight
       }

       // Make the background color show through
       func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
           let headerView = UIView()
           headerView.backgroundColor = UIColor.clear
           return headerView
       }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrderListViewCell
        
        cell.orderNo.text = "Order No : \(isiCell[indexPath.section].id!)"
        cell.pickUpTime.text = "Pick Up Time : \(isiCell[indexPath.section].pickUpTime!)"
        cell.customerDetails.text = isiCell[indexPath.section].customerId
        cell.orderPrice.text = "Rp. \(isiCell[indexPath.section].total!)"
        cell.orderDate.text = "29 Oktober 2019"
        cell.orderStatus.text = "\(isiCell[indexPath.section].status!)"
        if isiCell[indexPath.row].status == 3{
            cell.foodisReadyButton.isHidden = false
        }else {
            cell.foodisReadyButton.isHidden = true
        }

        return cell
    }
    
    
    
    
}

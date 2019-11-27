//
//  OrderListViewController.swift
//  OrderEat-Merchant
//
//  Created by Malvin Santoso on 14/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit
import PusherSwift
class OrderListViewController: UIViewController , UIImagePickerControllerDelegate , UINavigationControllerDelegate{
    
    @IBOutlet weak var tableView: UITableView!
    
    var masterViewController : MasterOrderListTableViewController! {
        return splitViewController?.viewControllers.first as! MasterOrderListTableViewController
    }
    
    let cellSpacingHeight: CGFloat = 10
    
    // Container
    var transactions : [Transaction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toScannerView" {
            let vc = segue.destination as! QRCodeScannerViewController
            vc.parentVC = self
        }
    }
    
    @IBAction func qrBtnPressed(_ sender: Any) {
        performSegue(withIdentifier: "toScannerView", sender: nil)
    }
}

extension OrderListViewController: UITableViewDelegate,UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return transactions.count
    }

    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }

    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrderListViewCell
        
        cell.transaction = transactions[indexPath.section]
        
        if transactions[indexPath.section].status == 2{
            cell.foodReadyClosure = {[unowned self] in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }else {
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Checkout", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "checkout") as! CheckoutViewController
        
        vc.transaction = transactions[indexPath.section]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

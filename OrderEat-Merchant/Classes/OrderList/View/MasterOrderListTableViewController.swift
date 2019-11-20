//
//  MasterOrderListTableViewController.swift
//  OrderEat-Merchant
//
//  Created by Malvin Santoso on 15/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class MasterOrderListTableViewController: UITableViewController {
    let cellLabel = [["Incoming","Waiting Payment","Ongoing","History"], ["Menu","Discount"]]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.title = CurrentUser.name
        self.title = CurrentUser.name
        
        let indexPath = IndexPath(row: 0, section: 0)
        
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellLabel[section].count
    }
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == 0{
            return "Order List"
        }
        else {
            return "Menu"
        }
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
                    let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MasterOrderListTableViewCell
        let section = indexPath.section
        let row = indexPath.row
        
        cell.tipeLabel.text = cellLabel[section][row]
        
        let cellBGView = UIView()
        cellBGView.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.5215686275, blue: 0.1294117647, alpha: 1)
        cell.selectedBackgroundView = cellBGView
        cell.tipeLabel.highlightedTextColor = .white
        cell.tipeNotifLabel.layer.backgroundColor  = #colorLiteral(red: 0.8588235294, green: 0.8941176471, blue: 0.4392156863, alpha: 1)
        cell.tipeNotifLabel.layer.cornerRadius = 12
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let vc = navigationController.topViewController as! OrderListViewController
        
        let indexPath = sender as! IndexPath
        let section = indexPath.section
        let row = indexPath.row
        
        vc.title = cellLabel[section][row]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: "changeDetails", sender: indexPath)
        }
        
    }
}

//
//  MasterOrderListTableViewController.swift
//  OrderEat-Merchant
//
//  Created by Malvin Santoso on 15/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class MasterOrderListTableViewController: UITableViewController {
    let tipe = ["Incoming","Waiting Payment","On Going","History"]
    let menu = ["Menu","Discount"]
    let isiData = OrderListViewModel.getTransaction()
    
    var color : UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        if section == 0{
            return tipe.count
        }else{
        return menu.count
    }
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
        if indexPath.section == 0 {

            cell.tipeLabel.text = tipe[indexPath.row]
            cell.tipeNotifLabel.text = "\(isiData.count)"
            let cellBGView = UIView()
            cellBGView.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.5215686275, blue: 0.1294117647, alpha: 1)
            cell.selectedBackgroundView = cellBGView
            cell.tipeLabel.highlightedTextColor = .white
            cell.tipeNotifLabel.layer.backgroundColor  = #colorLiteral(red: 0.8588235294, green: 0.8941176471, blue: 0.4392156863, alpha: 1)
            cell.tipeNotifLabel.layer.cornerRadius = 12
            
            return cell
        }
        else
        {
            cell.tipeLabel.text = menu[indexPath.row]
            cell.tipeNotifLabel.text = "\(isiData.count)"
            let cellBGView = UIView()
            cellBGView.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.5215686275, blue: 0.1294117647, alpha: 1)
            cell.selectedBackgroundView = cellBGView
            cell.tipeLabel.highlightedTextColor = .white
            cell.tipeNotifLabel.layer.backgroundColor  = #colorLiteral(red: 0.8588235294, green: 0.8941176471, blue: 0.4392156863, alpha: 1)
            cell.tipeNotifLabel.layer.cornerRadius = 12
            
            return cell
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let vc = navigationController.topViewController as! OrderListViewController
        
        vc.color = color
    }
    
    func changeDetails() {
        performSegue(withIdentifier: "changeDetails", sender: nil)
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let section = indexPath.section
        let row = indexPath.row
        
        if section == 0 {
            switch row {
            case 0:
                color = .red
                changeDetails()
            case 1:
                color = .blue
                changeDetails()
            case 2:
                color = .black
                changeDetails()
            case 3:
                color = .green
                changeDetails()
            default:
                break;
            }
        }
        else if section == 1 {
            switch row {
            case 0:
                color = .red
                changeDetails()
            case 1:
                color = .blue
                changeDetails()
            case 2:
                color = .black
                changeDetails()
            case 3:
                color = .green
                changeDetails()
            default:
                break;
            }
        }
    }
}

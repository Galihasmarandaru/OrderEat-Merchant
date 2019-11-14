//
//  OrderListTableViewController.swift
//  OrderEat-Merchant
//
//  Created by Malvin Santoso on 14/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class OrderListTableViewController: UITableViewController {

    
    var color : UIColor!
    override func viewDidLoad() {
        super.viewDidLoad()

        
        //color = .blue
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let vc = navigationController.topViewController as! OrderListViewController
        
        vc.color = color
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("section: ", indexPath.section)
        print("row: ", indexPath.row)
        
        if indexPath.section == 0 && indexPath.row == 0
        {
            performSegue(withIdentifier: "changeDetails", sender: nil)
            color = .red
        }else if indexPath.section == 0 && indexPath.row == 1
        {
            performSegue(withIdentifier: "changeDetails", sender: nil)
            color = .blue
        }else if indexPath.section == 0 && indexPath.row == 2
        {
            performSegue(withIdentifier: "changeDetails", sender: nil)
            color = .orange
        }else if indexPath.section == 0 && indexPath.row == 3
        {
            performSegue(withIdentifier: "changeDetails", sender: nil)
            color = .black
        }
    }
}

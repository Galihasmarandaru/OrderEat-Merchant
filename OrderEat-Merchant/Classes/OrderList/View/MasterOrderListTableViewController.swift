//
//  MasterOrderListTableViewController.swift
//  OrderEat-Merchant
//
//  Created by Malvin Santoso on 15/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit
import PusherSwift

class MasterOrderListTableViewController: UITableViewController {
    let cellLabel = [transactionHeader, menuHeader]
    
    let viewModel = MasterOrderListViewModel()
    
    var transactions : [[Transaction]] = []
    
    var detailViewController : OrderListViewController! {
        let detailNavigationController = splitViewController?.viewControllers[1] as! UINavigationController
        return detailNavigationController.viewControllers.first as? OrderListViewController
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.title = CurrentUser.name
        self.title = CurrentUser.name
        
        attemptFetchTransactions()
        
        // inital selected cell
        let indexPath = IndexPath(row: 0, section: 0)
        tableView.selectRow(at: indexPath, animated: false, scrollPosition: .none)
        
        // bind a callback to handle an event
        let _ = PusherChannels.channel.bind(eventName: "Transaction", eventCallback: { (event: PusherEvent) in
            if event.data != nil {
                self.attemptFetchTransactions()
            }
        })
        PusherChannels.pusher.connect()
        
    }
    
    func attemptFetchTransactions() {
        print("start fetch")
        
        viewModel.fetchTransactions()
        
        viewModel.updateLoadingStatus = {
            
        }
        
        viewModel.showAlertClosure = {
            if let errorString = self.viewModel.errorString {
                Alert.showErrorAlert(on: self, title: errorString) {
                    self.viewModel.fetchTransactions()
                }
            }
        }
        
        viewModel.didFinishFetch = {
            self.transactions = self.viewModel.transactions
            
            //print(self.transactions[0].count)
            
            DispatchQueue.main.async {
                self.tableView.reloadDataWithSelection()
                let generator = UIImpactFeedbackGenerator(style: .medium)
                generator.impactOccurred()

                let selectedRow = self.tableView.indexPathForSelectedRow!.row
                
                self.detailViewController.transactions = self.transactions[selectedRow]
                self.detailViewController.tableView.reloadData()
            }
        }
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
        
        if transactions.count != 0 && section == 0 && transactions[row].count > 0{
            cell.accessoryBadge.isHidden = false
            cell.transactionCount = transactions[row].count
        }
        else
        {
            cell.accessoryBadge.isHidden = true
        }
        
        return cell
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let navigationController = segue.destination as! UINavigationController
        let vc = navigationController.topViewController as! OrderListViewController
        
        let indexPath = sender as! IndexPath
        let section = indexPath.section
        let row = indexPath.row
        
        vc.title = cellLabel[section][row]
        vc.transactions = self.transactions[row]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0 {
            performSegue(withIdentifier: "changeDetails", sender: indexPath)
        }
    }
}

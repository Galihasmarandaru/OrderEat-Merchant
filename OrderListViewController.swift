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
    
    let transactionTitle = ["Incoming","Waiting Payment","Ongoing","History"]
    
    let cellSpacingHeight: CGFloat = 10
    
    // Injection
    let viewModel = OrderListViewModel()
    
    // Container
    var transactions : [Transaction] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Scan QR "), style: .plain, target: self, action:#selector(openCamera))
                
        setupRefreshControl()
    }

    
    override func viewWillAppear(_ animated: Bool) {
        attemptFetchTransactions()
        
        // bind a callback to handle an event
        let _ = PusherChannels.channel.bind(eventName: "Transaction", eventCallback: { (event: PusherEvent) in
            if event.data != nil {
                 // you can parse the data as necessary
                 // print(data)
                print("trying refresh ongoing pagee")
                self.attemptFetchTransactions()

               }
           })
        PusherChannels.pusher.connect()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        PusherChannels.pusher.disconnect()
    }
    
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(attemptFetchTransactions), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func attemptFetchTransactions() {
        let status : APIRequest.TransactionStatus
        
        switch transactionTitle.firstIndex(of: self.title!) {
        case 0:
            status = .incoming
        case 1:
            status = .waitForPayment
        case 2:
            status = .ongoing
        case 3:
            status = .history
        default:
            status = .incoming
        }
        
        viewModel.fetchTransactions(status: status)
        
        viewModel.updateLoadingStatus = {
            
        }
        
        viewModel.showAlertClosure = {
            if let errorString = self.viewModel.errorString {
                Alert.showErrorAlert(on: self, title: errorString) {
                    self.viewModel.fetchTransactions(status: status)
                }
            }
        }
        
        viewModel.didFinishFetch = {
            if let transactions = self.viewModel.transactions {
                self.transactions = transactions
                
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
            }
        }
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

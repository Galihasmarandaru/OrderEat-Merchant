//
//  OrderListViewController.swift
//  OrderEat-Merchant
//
//  Created by Malvin Santoso on 14/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

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
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: #imageLiteral(resourceName: "Scan QR "), style: .plain, target: self, action:#selector(openCamera))
    }
    
    override func viewWillAppear(_ animated: Bool) {
        attemptFetchTransaction()
    }
    
    func setupRefreshControl() {
        let refreshControl = UIRefreshControl()
        refreshControl.addTarget(self, action: #selector(attemptFetchTransaction), for: .valueChanged)
        tableView.refreshControl = refreshControl
    }
    
    @objc func attemptFetchTransaction() {
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
            
        }
        
        viewModel.didFinishFetch = {
            if let transactions = self.viewModel.transactions {
                self.transactions = transactions
                
            }
            
            DispatchQueue.main.async {
                print("finish fetch")
                self.tableView.reloadData()
                self.tableView.refreshControl?.endRefreshing()
            }
        }
    }
    
    @objc func openCamera(){
//        let storyboard = UIStoryboard(name: "OrderList", bundle: nil)
//        let qrScanPage = storyboard.instantiateViewController(identifier: "QRCodeScannerViewController") as! QRCodeScannerViewController
//        let appDelegate = UIApplication.shared.windows
//        appDelegate.first?.rootViewController = qrScanPage
        
        performSegue(withIdentifier: "toScannerView", sender: nil)
    }
}

extension OrderListViewController: UITableViewDelegate,UITableViewDataSource{

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    // There is just one row in every section
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return transactions.count
    }

    // Set the spacing between sections
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return cellSpacingHeight
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! OrderListViewCell
        
        cell.transaction = transactions[indexPath.row]
        
        if transactions[indexPath.row].status == 2{
            cell.foodisReadyButton.isHidden = false
            cell.foodReadyClosure = {[unowned self] in
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }
            
        }else {
            cell.foodisReadyButton.isHidden = true
        }

        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "Checkout", bundle: nil)
        let vc = storyboard.instantiateViewController(identifier: "checkout") as! CheckoutViewController
        
        vc.transaction = transactions[indexPath.row]
        
        navigationController?.pushViewController(vc, animated: true)
    }
}

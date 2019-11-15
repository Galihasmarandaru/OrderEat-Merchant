//
//  OrderListTableViewController.swift
//  OrderEat-Merchant
//
//  Created by Malvin Santoso on 14/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class OrderListTableViewController: UITableViewController {

    
    @IBOutlet weak var historyLabel: UILabel!
    @IBOutlet weak var onGoingLabel: UILabel!
    @IBOutlet weak var waitingLabel: UILabel!
    @IBOutlet weak var incomingLabel: UILabel!
    @IBOutlet weak var notifIncoming: UILabel!
    @IBOutlet weak var notifWaitingPayment: UILabel!
    @IBOutlet weak var notifOnGoing: UILabel!
    @IBOutlet weak var notifHistory: UILabel!
    var isiCell = OrderListViewModel.getTransaction()
    var color : UIColor!
    override func viewDidLoad() {
        super.viewDidLoad()
        showNotif()
    }
    func showNotif(){ //buat kasih tau jumlah isi incoming,waitingpayment,ongoing,history
        if isiCell.count == 0 {
            notifIncoming.isHidden = true
            notifOnGoing.isHidden = true
            notifWaitingPayment.isHidden = true
            notifHistory.isHidden = true
        }else{
            notifIncoming.layer.backgroundColor  = #colorLiteral(red: 0.8588235294, green: 0.8941176471, blue: 0.4392156863, alpha: 1)
            notifIncoming.layer.cornerRadius = 13
            notifWaitingPayment.layer.backgroundColor  = #colorLiteral(red: 0.8588235294, green: 0.8941176471, blue: 0.4392156863, alpha: 1)
            notifWaitingPayment.layer.cornerRadius = 13
            notifOnGoing.layer.backgroundColor  = #colorLiteral(red: 0.8588235294, green: 0.8941176471, blue: 0.4392156863, alpha: 1)
            notifOnGoing.layer.cornerRadius = 13
            notifHistory.layer.backgroundColor  = #colorLiteral(red: 0.8588235294, green: 0.8941176471, blue: 0.4392156863, alpha: 1)
            notifHistory.layer.cornerRadius = 13
            
            notifIncoming.text = "\(isiCell.count)"
            notifOnGoing.text = "\(isiCell.count)"
            notifWaitingPayment.text = "\(isiCell.count)"
            notifHistory.text = "\(isiCell.count)"
            
            notifIncoming.isHidden = false
            notifOnGoing.isHidden = false
            notifWaitingPayment.isHidden = false
            notifHistory.isHidden = false
        }
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
            color = .red
            incomingLabel.textColor = .white
            onGoingLabel.textColor = .black
            historyLabel.textColor = .black
            waitingLabel.textColor = .black
            
            performSegue(withIdentifier: "changeDetails", sender: nil)
        }else if indexPath.section == 0 && indexPath.row == 1
        {
            color = .blue
            incomingLabel.textColor = .black
            waitingLabel.textColor = .white
            onGoingLabel.textColor = .black
            historyLabel.textColor = .black
            
            performSegue(withIdentifier: "changeDetails", sender: nil)
        }else if indexPath.section == 0 && indexPath.row == 2
        {
            color = .orange
            incomingLabel.textColor = .black
            waitingLabel.textColor = .black
            onGoingLabel.textColor = .white
            historyLabel.textColor = .black
            performSegue(withIdentifier: "changeDetails", sender: nil)
            
        }else if indexPath.section == 0 && indexPath.row == 3
        {
            color = .black
            incomingLabel.textColor = .black
            waitingLabel.textColor = .black
            onGoingLabel.textColor = .black
            historyLabel.textColor = .white
            performSegue(withIdentifier: "changeDetails", sender: nil)
        }
    }
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
          let cellBGView = UIView()
        cellBGView.backgroundColor = #colorLiteral(red: 0.9647058824, green: 0.5215686275, blue: 0.1294117647, alpha: 1)
          cell.selectedBackgroundView = cellBGView
        
              
    }

 

}

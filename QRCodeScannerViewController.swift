//
//  QRCodeScannerViewController.swift
//  OrderEat-Merchant
//
//  Created by Malvin Santoso on 18/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class QRCodeScannerViewController: UIViewController {

      @IBOutlet weak var scannerView: QRScannerView! {
            didSet {
                scannerView.delegate = self
            }
        }

        
        var qrData: QRData? = nil {
            didSet {
                if qrData != nil {
//                    self.performSegue(withIdentifier: "CheckOutOrderSegue", sender: self) //SEGUENYA BELOM DIBUAT
                    print(qrData!)
                }
            }
        }
        
        override func viewDidLoad() {
            super.viewDidLoad()
        }

    
        
     
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            navigationController?.setNavigationBarHidden(true, animated: false)

            if !scannerView.isRunning {
                scannerView.startScanning()
            }
        }
   
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            navigationController?.setNavigationBarHidden(false, animated: false)
            if !scannerView.isRunning {
                scannerView.stopScanning()
            }
        }
    @IBAction func backButton(_ sender: Any) {
        navigationController?.popViewController(animated: true)
    }
}


extension QRCodeScannerViewController:QRScannerViewDelegate {
    func qrScanningDidStop() {
        print("fail")
    }
    
        
        func qrScanningDidFail() {
            presentAlert(withTitle: "Error", message: "Scanning Failed. Please try again")
        }
        
        func qrScanningSucceededWithCode(_ str: String?) {
            self.qrData = QRData(codeString: str)
        }
        
        
        
    }

extension QRCodeScannerViewController {
    
    func presentAlert(withTitle title: String, message : String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let OKAction = UIAlertAction(title: "OK", style: .default) { action in
            print("You've pressed OK Button")
        }
        alertController.addAction(OKAction)
        self.present(alertController, animated: true, completion: nil)
    }
    func showToast(message : String, seconds: Double = 2.0) {
        let alert = UIAlertController(title: nil, message: message, preferredStyle: .alert)
        alert.view.backgroundColor = UIColor.black
        alert.view.alpha = 0.6
        alert.view.layer.cornerRadius = 15
        
        self.present(alert, animated: true)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + seconds) {
            alert.dismiss(animated: true)
        }
    }
}

//INI NYALAIN NANTI KALO UDH BKIN FUNCTION SEGUE KE PAGE ABIS SCAN

//    extension QRCodeScannerViewController {
//        override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//            if segue.identifier == "detailSeuge", let viewController = segue.destination as? CheckoutViewController {
//                viewController.qrData = self.qrData
//            }
//        }
//    }





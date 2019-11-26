//
//  MasterOrderListViewModel.swift
//  OrderEat-Merchant
//
//  Created by Frederic Orlando on 26/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation

class MasterOrderListViewModel{
    var transactions : [[Transaction]] = [[],[],[],[]] {
       didSet {
           self.didFinishFetch?()
       }
    }
    
    var errorString : String? {
        didSet {
            self.showAlertClosure?()
        }
    }

    var isLoading : Bool = false {
        didSet {
            self.updateLoadingStatus?()
        }
    }

    // Closures for callback
    var showAlertClosure : (() -> ())?
    var updateLoadingStatus : (() -> ())?
    var didFinishFetch : (() -> ())?

    //Network call
//    func fetchTransactions(status : APIRequest.TransactionStatus) {
//        isLoading = true
//
//        APIRequest.getTransactions(merchantId: CurrentUser.id, status: status, completion: { (transactions, error) in
//            if let error = error {
//                self.errorString = error.rawValue
//                self.isLoading = false
//                return
//            }
//            self.errorString = nil
//            self.isLoading = false
//            //self.transactions = transactions
//        })
//    }
    
    func fetchTransactions() {
        for status in APIRequest.TransactionStatus.allCases {
            
            isLoading = true
            APIRequest.getTransactions(status: status) { (transactions, error) in
                if let error = error {
                self.errorString = error.rawValue
                self.isLoading = false
                return
                }
                self.errorString = nil
                self.isLoading = false
                
                var tempTransactions : [Transaction]
                
                tempTransactions = transactions ?? [Transaction]()
                
                self.transactions[status.index] = tempTransactions
            }
            
        }
    }
}

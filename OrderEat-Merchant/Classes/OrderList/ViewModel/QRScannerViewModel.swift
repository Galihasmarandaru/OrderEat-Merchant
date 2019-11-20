//
//  QRScannerViewModel.swift
//  OrderEat-Merchant
//
//  Created by Frederic Orlando on 20/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation

class QRScannerViewModel{
    var transaction : Transaction? {
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
    func fetchTransactionDetail(id : String) {
        isLoading = true

        APIRequest.getDetail(.transactions, id: id) { (transaction, error) in
            if let error = error {
                self.errorString = error.rawValue
                self.isLoading = false
                return
            }
            self.errorString = nil
            self.isLoading = false
            self.transaction = transaction as? Transaction
        }
    }
}

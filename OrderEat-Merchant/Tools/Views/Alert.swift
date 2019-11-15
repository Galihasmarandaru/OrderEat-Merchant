//
//  Alert.swift
//  OrderEat-Merchant
//
//  Created by Gregory Kevin on 15/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation
import UIKit

struct Alert {
    static func showBasicAlert(on vc: UIViewController, with title: String, message: String, yesAction: @escaping () -> (), noAction: @escaping () -> ()) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Yes", style: .default, handler: { (action) in
            yesAction()
        }))
        alert.addAction(UIAlertAction(title: "No", style: .default, handler: { (action) in
            noAction()
        }))
        
        DispatchQueue.main.async {
            vc.present(alert, animated: true)
        }
    }
}

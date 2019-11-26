//
//  UITableView.swift
//  OrderEat-Merchant
//
//  Created by Frederic Orlando on 26/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
    func reloadDataWithSelection() {
        let selectedRow = indexPathForSelectedRow
        
        reloadData()
        
        selectRow(at: selectedRow, animated: false, scrollPosition: .none)
    }
}

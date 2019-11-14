//
//  CheckoutViewModel.swift
//  OrderEat-Merchant
//
//  Created by Gregory Kevin on 14/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation
import UIKit

struct CheckoutViewModel {
    static func getDataMenuTransaction() -> [Menu] {
        let cell: [Menu] = [Menu(name: "Burger", price: 20000), Menu(name: "Noodle", price: 25000), Menu(name: "Chicken", price: 15000)]
        
        return cell
    }
}

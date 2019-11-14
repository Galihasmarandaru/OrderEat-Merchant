//
//  OrderListViewModel.swift
//  OrderEat-Merchant
//
//  Created by Malvin Santoso on 14/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation

struct OrderListViewModel{
static func getTransaction() -> [Transaction]{
    let isiCell:[Transaction] = [Transaction(id: "D-01", pickUpTime: "12.00", customer: "Ardel", total: 20000, status: 2),Transaction(id: "D-02", pickUpTime: "15.00", customer: "Malvin", total: 220000, status: 3)]
    return isiCell
}
}

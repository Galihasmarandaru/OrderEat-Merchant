//
//  String.swift
//  OrderEat-Merchant
//
//  Created by Frederic Orlando on 19/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation

extension String {
    var time : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        
        let date = formatter.date(from: self)
        
        formatter.dateFormat = "HH:mm"
        
        //let string = formatter.string(from: date!)
        
        return self
    }
}

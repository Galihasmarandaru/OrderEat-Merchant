//
//  String.swift
//  OrderEat-Merchant
//
//  Created by Frederic Orlando on 19/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation
import CryptoKit

extension String {
    var time : String {
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm:ss"
        
        let date = formatter.date(from: self)
        
//        print(date)
        
        formatter.dateFormat = "HH:mm"
        
        //let string = formatter.string(from: date!)
        
        return self
    }
    
    var encrypted : String {
        let passwordString = self
        let salt = "aKnasdJaOmuHn{r8+i129sa.[fa"
        let passwordData = Data((passwordString + salt).utf8)

        let hashed = SHA256.hash(data: passwordData)

        let hashString = hashed.compactMap { String(format: "%02x", $0) }.joined()

        return hashString
    }
}

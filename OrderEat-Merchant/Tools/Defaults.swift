//
//  UserDefaults.swift
//  OrderEat-Customer
//
//  Created by Frederic Orlando on 20/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import Foundation

struct Defaults {
    static let userLogin = "userLogin"
    static let id = "merchantId"
    static let token = "merchantToken"
    
    static func saveMerchantData(token merchantToken: String, id merchantId: String){
        UserDefaults.standard.set(merchantToken, forKey: token)
        UserDefaults.standard.set(merchantId, forKey: id)
    }
    
    static func getToken() -> String{
        let customerName = UserDefaults.standard.string(forKey: token) ?? ""
        
        return customerName
    }
    
    static func getId() -> String{
        let customerId = UserDefaults.standard.string(forKey: id) ?? ""
        
        return customerId
    }
    
    static func saveUserLogin(_ isUserLogin: Bool){
        UserDefaults.standard.set(isUserLogin, forKey: userLogin)
    }
    
    static func getUserLogin() -> Bool {
        let userLogin = UserDefaults.standard.bool(forKey: self.userLogin)
        
        return userLogin
    }
    
    static func clearUserData(){
        UserDefaults.standard.removeObject(forKey: userLogin)
        UserDefaults.standard.removeObject(forKey: id)
        UserDefaults.standard.removeObject(forKey: token)
    }
}

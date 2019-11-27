//
//  Info.swift
//  OrderEat-Merchant
//
//  Created by Galih Asmarandaru on 15/11/19.
//  Copyright © 2019 Galih Asmarandaru. All rights reserved.
//

import UIKit

class SigninViewController: UIViewController {
    
    
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if Defaults.getUserLogin() {
            
            CurrentUser.id = Defaults.getId()
            CurrentUser.accessToken = Defaults.getToken()
            PusherChannels.subscribePushChannel(channel: CurrentUser.id)
            
            let storyboard = UIStoryboard(name: "OrderList", bundle: nil)
            let tabBarVC = storyboard.instantiateViewController(identifier: "OrderList")
            let appDelegate = UIApplication.shared.windows
            appDelegate.first?.rootViewController = tabBarVC
        }
        
    }
    
    
    @IBAction func signinTapped(_ sender: Any) {
        guard let email = emailTextField.text, let password = passwordTextField.text else {
            return
        }
        
        let params = [
            "email": email,
//            "password": password

            "password": password.encrypted
        ]
        
        APIRequest.signin(parameter: params) { (isVerified, error) in
            
            if let error = error {
                print(error)
                return
           }
           
           if isVerified! {
               DispatchQueue.main.async {
                   
                   if (CurrentUser.id != "") {
                       print(CurrentUser.accessToken)
                       PusherChannels.subscribePushChannel(channel: CurrentUser.id)
                       PusherBeams.registerDeviceInterest(pushInterest: CurrentUser.id)
                   }
                   
                   let storyboard = UIStoryboard(name: "OrderList", bundle: nil)
                   let tabBarVC = storyboard.instantiateViewController(identifier: "OrderList")
                   let appDelegate = UIApplication.shared.windows
                   appDelegate.first?.rootViewController = tabBarVC
               }
              
           }
            
        }
        
        
        
    }
}

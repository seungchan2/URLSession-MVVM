//
//  SignInViewModel.swift
//  SeSAC_Test
//
//  Created by 김승찬 on 2021/12/27.
//

import Foundation
import UIKit

class SignInViewModel {
    
    var email2: String = ""
    
    var username: Observable<String> = Observable("고래밥")
    var password: Observable<String> = Observable("")
    
    
    
    func postUserLogin(completion: @escaping () -> Void) {
        APIService.login(identifier: username.value, password: password.value) { userData, error in
            
            guard let userData = userData else {
                return
            }
            
            UserDefaults.standard.set(userData.jwt, forKey: "token")
            UserDefaults.standard.set(userData.user.username, forKey: "nickname")
            UserDefaults.standard.set(userData.user.id, forKey: "id")
            UserDefaults.standard.set(userData.user.email, forKey: "email")
            
            completion()
            
        }
    }
}


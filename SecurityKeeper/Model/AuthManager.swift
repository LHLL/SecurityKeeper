//
//  AuthManager.swift
//  SecurityKeeper
//
//  Created by 李玲 on 11/24/17.
//  Copyright © 2017 Jay. All rights reserved.
//

import Foundation
import LocalAuthentication

protocol AuthDelegate:class {
    func succeedAuthenticateUser()
    func failedAuthenticateUser(_ reason:String)
}

class AuthManager {
    weak var delegate:AuthDelegate?
    static var shared = AuthManager()
    
    private init(){}
    
    func authenticateUser(){
        let context = LAContext()
        var error: NSError?
        
        if context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            let reason = "Authenticate youself to decrypt your senstive data!"
            context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) {[weak self] (success, authenticationError) in
                DispatchQueue.main.async {
                    if success {
                        self?.delegate?.succeedAuthenticateUser()
                    } else {
                        if (authenticationError as! LAError).code == LAError.userFallback {
                            
                        }else{
                           self?.delegate?.failedAuthenticateUser(authenticationError!.localizedDescription)
                        }
                    }
                }
            }
        } else {
            self.delegate?.failedAuthenticateUser("Your device does not support Touch ID or Face ID")
        }
    }
}

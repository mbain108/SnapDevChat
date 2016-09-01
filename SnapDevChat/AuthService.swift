//
//  AuthService.swift
//  SnapDevChat
//
//  Created by Melissa Bain on 9/1/16.
//  Copyright © 2016 MB Consulting. All rights reserved.
//

import Foundation
import FirebaseAuth

class AuthService {
    
    private static let _instance = AuthService()
    
    static var instance: AuthService {
        
        return _instance
    }
    
    func login(email: String, password: String) {
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
            
            if error != nil {
                if let errorCode = FIRAuthErrorCode(rawValue: error!._code) {
                    if errorCode == .errorCodeUserNotFound {
                        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { (user, error) in
                            if error != nil {
                                // Show error to user
                            } else {
                                if user?.uid != nil {
                                    // Sign-in
                                    FIRAuth.auth()?.signIn(withEmail: email, password: password, completion: { (user, error) in
                                        if error != nil {
                                            // Show error to user
                                        } else {
                                            // We have successfully logged in
                                        }
                                    })
                                }
                            }
                        })
                    }
                } else {
                    // Handle all other errors
                }
            } else {
                // Successfully logged in
            }
        })
    }
}

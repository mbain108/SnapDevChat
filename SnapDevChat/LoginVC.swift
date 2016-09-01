//
//  LoginVC.swift
//  SnapDevChat
//
//  Created by Melissa Bain on 8/31/16.
//  Copyright © 2016 MB Consulting. All rights reserved.
//

import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var emailField: RoundedTextField!
    @IBOutlet weak var passwordField: RoundedTextField!

    override func viewDidLoad() {
     
        super.viewDidLoad()
    }
    
    @IBAction func loginButtonPressed(_ sender: AnyObject) {
        
        if let email = emailField.text, let pass = passwordField.text , (email.characters.count > 0 && pass.characters.count > 0) {
            
            AuthService.instance.login(email: email, password: pass, onComplete: { (errMsg, data) in
            
                guard errMsg == nil else {
                    
                    let alert = UIAlertController(title: "Error Authentication", message: errMsg, preferredStyle: .alert)

                    alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                    self.present(alert, animated: true, completion: nil)
                    
                    return
                }
                
                self.dismiss(animated: true, completion: nil)
            })
        } else {
            let alert = UIAlertController(title: "Username and Password Required", message: "You must enter both a username and a password", preferredStyle: .alert)
            
            alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
            
            present(alert, animated: true, completion: nil)
            
        }
    }
}

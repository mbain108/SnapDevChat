//
//  User.swift
//  SnapDevChat
//
//  Created by Melissa Bain on 9/1/16.
//  Copyright © 2016 MB Consulting. All rights reserved.
//

import UIKit

struct User {
    
    private var _uid: String
    private var _firstName: String
    
    var uid: String {
        
        return _uid
    }
    
    var firstName: String {
        
        return _firstName
    }
    
    init(uid: String, firstName: String) {
        
        _uid = uid
        _firstName = firstName
    }
}

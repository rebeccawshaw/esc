//
//  DataService.swift
//  esc
//
//  Created by Rebecca Shaw on 4/4/16.
//  Copyright © 2016 Rebecca Shaw. All rights reserved.
//

import UIKit

class DataService {
    static let dataService = DataService()
    
    private var _BASE_REF = Firebase(url: "https://escapp.firebaseio.com")
    
    var BASE_REF: Firebase {
        return _BASE_REF
    }
    
    var USER_REF: Firebase {
        let uid = BASE_REF.authData.uid
        return BASE_REF.childByAppendingPath("users/\(uid)")
    }
    
    var DATA_REF: Firebase {
        return USER_REF.childByAppendingPath("data")
    }

    func createNewAccount(uid: String, email: Dictionary<String, String>) {
        
        // A User is born.
        USER_REF.setValue(email)
    }
}
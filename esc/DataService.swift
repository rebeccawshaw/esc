//
//  DataService.swift
//  esc
//
//  Created by Rebecca Shaw on 4/4/16.
//  Copyright © 2016 Rebecca Shaw. All rights reserved.
//

import UIKit
import Firebase

class DataService {
    static let dataService = DataService()
    
    private var _BASE_REF = Firebase(url: "https://escapp.firebaseio.com")
    
    var BASE_REF: Firebase {
        return _BASE_REF
    }
    
    var USER_REF: Firebase {
        let uid = BASE_REF.authData.uid
        return BASE_REF.childByAppendingPath("\(uid)")
    }
    
    var DATA_REF: Firebase {
        return USER_REF.childByAppendingPath("esc")
    }
    
    var FRIEND_REF: Firebase {
        return USER_REF.childByAppendingPath("friends")
    }
    
    var MESSAGE_REF: Firebase {
        return USER_REF.childByAppendingPath("messages")
    }

    func createNewAccount(uid: String, email: Dictionary<String, String>, username: String) {
        
        // A User is born
        BASE_REF.updateChildValues([username: uid])
        USER_REF.updateChildValues(email)
        
        let usern: [String: AnyObject!] = ["username": username]
        USER_REF.updateChildValues(usern)
        
        let obj: [String: AnyObject!] = ["esc": "", "time": "", "location": ""]
        DATA_REF.updateChildValues(obj)
    }
}
//
//  User.swift
//  esc
//
//  Created by Rebecca Shaw on 4/4/16.
//  Copyright © 2016 Rebecca Shaw. All rights reserved.
//

import UIKit

class User {
    // MARK: Properties
    
    private var _username: String
    private var _esc: String
    private var _time: String
    private var _loc: String
    
    var username: String {
        return _username
    }
    
    var esc: String {
        return _esc
    }
    
    var time: String {
        return _time
    }
    
    var loc: String {
        return _loc
    }
    
    // MARK: Initialization
    
    init?(username: String, esc: String, time: String, loc: String) {
        
        // Initialize stored properties.
        self._username = username
        self._esc = esc
        self._time = time
        self._loc = loc
        
        // Initialization should fail if there is no email
        if username.isEmpty {
            return nil
        }
    }
}
    
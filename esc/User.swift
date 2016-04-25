//
//  User.swift
//  esc
//
//  Created by Rebecca Shaw on 4/4/16.
//  Copyright © 2016 Rebecca Shaw. All rights reserved.
//

import UIKit
import Firebase

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
        self._username = username
        self._esc = esc
        self._time = time
        self._loc = loc
    }
    
    init(snapshot: FDataSnapshot) {
        _username = snapshot.value.objectForKey("username") as! String
        _esc = snapshot.childSnapshotForPath("esc").value.objectForKey("esc") as! String
        _time = snapshot.childSnapshotForPath("esc").value.objectForKey("time") as! String
        _loc = snapshot.childSnapshotForPath("esc").value.objectForKey("location") as! String
    }
}
    
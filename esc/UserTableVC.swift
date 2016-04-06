//
//  UserTableVC.swift
//  esc
//
//  Created by Rebecca Shaw on 4/4/16.
//  Copyright © 2016 Rebecca Shaw. All rights reserved.
//

import UIKit

class UserTableVC: UITableViewController {

    //MARK: properties
    var users = [User]()

    var timer: NSTimer?
    var time: NSDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadUsers()
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: #selector(UserTableVC.updateProfile), userInfo: nil, repeats: true)
    }
    
    func updateProfile () {
        if (time?.timeIntervalSinceNow > 0) {
            //valid
        } else {
            //offline
            timer?.invalidate()
        }
    }
    
    func loadUsers() {
        let usr1 = User(email: "1", esc: "2", time: "3", loc: "4")!
        
        let usr2 = User(email: "5", esc: "6", time: "7", loc: "8")!
        
        let usr3 = User(email: "9", esc: "10", time: "11", loc: "12")!
        
        users += [usr1, usr2, usr3]
        // Retrieve new posts as they are added to your database
//        DataService.dataService.USER_REF.observeEventType(.Value, withBlock: { snapshot in
//
//            self.users = []
//            
//            //format time
//            let strEmail = snapshot.value.objectForKey("email") as! String
//            
//            DataService.dataService.DATA_REF.observeEventType(.Value, withBlock: { snapshot in
//                
//                let stresc = snapshot.value.objectForKey("esc") as! String
//                let strTime = snapshot.value.objectForKey("time") as! String
//                let strLoc = snapshot.value.objectForKey("location") as! String
//                
//                let usr = User(email: strEmail, esc: stresc, time: strTime, loc: strLoc)!
//                
//                self.users += [usr]
//                
//                //format time
//                let timeFormatter = NSDateFormatter()
//                timeFormatter.dateFormat = "hh:mm a"
//                //self.time = timeFormatter.dateFromString(usr.time)
//                self.time = timeFormatter.dateFromString(strTime)
//                
//                self.tableView.reloadData()
//            })
//        })
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "UserTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UserTableViewCell

        // Fetches the appropriate user for the data source layout.
        let user = users[indexPath.row]
        cell.usrLabel.text = user.email
        cell.dataLabel.text = "\(user.esc) until \(user.time) at \(user.loc)"
        
        return cell
    }
}

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
        
        // expires user input settings to meet up
        // timer is set to call updateProfile() every second
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: #selector(UserTableVC.updateProfile), userInfo: nil, repeats: true)
    }
    
    // helper function to take action once timer is up
    func updateProfile () {
        if (time?.timeIntervalSinceNow > 0) {
            //valid
        } else {
            // offline
            timer?.invalidate()
            
            // if current time is greater then set time, then set all values to empty so user goes offline
            let obj: [String: AnyObject!] = ["esc": "", "time": "", "location": ""]
            DataService.dataService.DATA_REF.updateChildValues(obj)

        }
    }
    
    // load data from users
    // own information gets put in first cell, connected friends get put in subsequent cells
    func loadUsers() {
        
        // retrieve own data & put it in first row
        loadData(DataService.dataService.BASE_REF.authData.uid)
        // Retrieve new posts as they are added to your database
            
        // retrieve data from friends
        DataService.dataService.FRIEND_REF.observeEventType(.ChildChanged, withBlock: { snapshot in
            for child in snapshot.children {
                self.loadData(child.value)
            }
        })
    }
    
    // helper function for loadUsers, loads data from username passed in as parameter
    func loadData(uid: String) {
        DataService.dataService.BASE_REF.childByAppendingPath(uid).observeEventType(.Value, withBlock: { snapshot in
            
            var newUsers = [User]()
            
            let strName = snapshot.value.objectForKey("username") as! String
            
            DataService.dataService.BASE_REF.childByAppendingPath("\(uid)/esc").observeEventType(.Value, withBlock: {
                snapshot in
                
                let stresc = snapshot.value.objectForKey("esc") as! String
                let strTime = snapshot.value.objectForKey("time") as! String
                let strLoc = snapshot.value.objectForKey("location") as! String
                
                let usr = User(username: strName, esc: stresc, time: strTime, loc: strLoc)!
                
                newUsers.append(usr)
                
                //format time
                let timeFormatter = NSDateFormatter()
                timeFormatter.dateFormat = "hh:mm a"
                self.time = timeFormatter.dateFromString(strTime)
                
                self.users = newUsers
                self.tableView.reloadData()
            })
        })
    }
    
    // parameters for users
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    // parameters for users
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    // table view for the users
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        // Table view cells are reused and should be dequeued using a cell identifier.
        let cellIdentifier = "UserTableViewCell"
        
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath) as! UserTableViewCell

        // Fetches the appropriate user for the data source layout.
        let user = users[indexPath.row]
        cell.usrLabel.text = user.username
        if user.esc == "" {
            cell.dataLabel.text = "offline"
            cell.dataLabel.textColor = UIColor.redColor()
        } else {
            cell.dataLabel.text = "\(user.esc) until \(user.time) at \(user.loc)"
            cell.dataLabel.textColor = UIColor.greenColor()
        }
        
        return cell
    }
    
    // when user "saves" from escVC
    @IBAction func unwindToESC(sender: UIStoryboardSegue) {
        if let sourceViewController = sender.sourceViewController as? escVC {
            let obj: [String: AnyObject!] = ["esc": sourceViewController.esc]
            DataService.dataService.DATA_REF.updateChildValues(obj)
            
            let timeFormatter = NSDateFormatter()
            timeFormatter.dateFormat = "hh:mm a"
            let strTime = timeFormatter.stringFromDate(sourceViewController.pickTime.date)
            
            let tm: [String: AnyObject!] = ["time": strTime]
            DataService.dataService.DATA_REF.updateChildValues(tm)
            
            let loc: [String: AnyObject!] = ["location": sourceViewController.location]
            DataService.dataService.DATA_REF.updateChildValues(loc)
        }
    }
    
    // exeutes whenever segue is performed
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        super.prepareForSegue(segue, sender: sender)
        if segue.identifier == "change_esc" {   // go to change esc settings
            // nothing
        } else {    // go to chat
            // Retrieve the destination view controller from segue and cast it to a UINavigationController.
            let navVC = segue.destinationViewController as! UINavigationController
            // Cast the first view controller of the UINavigationController as ChatViewController.
            let chatVC = navVC.viewControllers.first as! ChatVC
            // Assign the local user’s ID to chatVc.senderId; this is the local ID that JSQMessagesViewController uses to coordinate messages.
            chatVC.senderId = DataService.dataService.BASE_REF.authData.uid
            // Make chatVc.senderDisplayName the username
            DataService.dataService.USER_REF.observeEventType(.Value, withBlock: { snapshot in
                chatVC.senderDisplayName = snapshot.value.objectForKey("username") as! String
            })
        }
    }
    
    // signs user out
    @IBAction func signOutTapped(sender: UIBarButtonItem) {
        DataService.dataService.BASE_REF.unauth()
        self.view.window?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}

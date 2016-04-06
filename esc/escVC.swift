//
//  ViewController.swift
//  esc
//
//  Created by Rebecca Shaw on 3/19/16.
//  Copyright © 2016 Rebecca Shaw. All rights reserved.
//

import UIKit

class escVC: UIViewController {

    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var eatButton: UIButton!
    @IBOutlet weak var studyButton: UIButton!
    @IBOutlet weak var chillButton: UIButton!
    @IBOutlet weak var statusText: UILabel!
    
    var esc: NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Retrieve new posts as they are added to your database
        DataService.dataService.USER_REF.observeEventType(.Value, withBlock: { snapshot in
            self.statusText.text = snapshot.value.objectForKey("email") as! String
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func eatTapped(sender: UIButton) {
        esc = "eat"
        self.performSegueWithIdentifier("goto_time", sender: self)
    }
    
    @IBAction func studyTapped(sender: UIButton) {
        esc = "study"
        self.performSegueWithIdentifier("goto_time", sender:self)
    }
    
    @IBAction func chillTapped(sender: UIButton) {
        esc = "chill"
        self.performSegueWithIdentifier("goto_time", sender:self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goto_time" {
            // Create a new user dictionary accessing the user's info
            // provided by the authData parameter
            let obj: [String: AnyObject!] = ["esc": esc]
            DataService.dataService.DATA_REF.updateChildValues(obj)
        }
    }
    
    @IBAction func signOutTapped(sender: UIButton) {
        DataService.dataService.BASE_REF.unauth()
        self.view.window?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}


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
    
    let ref = Firebase(url: "https://escapp.firebaseio.com")
    var esc: NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let email = ref.authData.provider
        statusText.text = email
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
            let ref = Firebase(url: "https://escapp.firebaseio.com")
            let uid = ref.authData.uid
            let userRef = Firebase(url: "https://escapp.firebaseio.com/\(uid)")
            let obj: [String: AnyObject!] = ["esc": esc]
            userRef.updateChildValues(obj)
        }
    }
    
    @IBAction func signOutTapped(sender: UIButton) {
        ref.unauth()
        self.view.window?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
}


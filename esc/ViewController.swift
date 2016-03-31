//
//  ViewController.swift
//  esc
//
//  Created by Rebecca Shaw on 3/19/16.
//  Copyright © 2016 Rebecca Shaw. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var eatButton: UIButton!
    @IBOutlet weak var studyButton: UIButton!
    @IBOutlet weak var chillButton: UIButton!
    @IBOutlet weak var statusText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        let ref = Firebase(url: "https://escapp.firebaseio.com")
        ref.observeAuthEventWithBlock({ authData in
            if authData != nil {
                self.performSegueWithIdentifier("goto_login", sender: nil)
            } else {
                // No user is signed in
            }
        })
    }
    
    @IBAction func eatTapped(sender: UIButton) {
        self.performSegueWithIdentifier("eat_to_time", sender: self)
    }
    
    @IBAction func studyTapped(sender: UIButton) {
        self.performSegueWithIdentifier("study_to_time", sender:self)
    }
    
    @IBAction func chillTapped(sender: UIButton) {
        self.performSegueWithIdentifier("chill_to_time", sender:self)
    }
    
    
    @IBAction func signOutTapped(sender: UIButton) {
        let ref = Firebase(url: "https://escapp.firebaseio.com")
        ref.unauth()
        self.performSegueWithIdentifier("goto_login", sender: self)
    }
}


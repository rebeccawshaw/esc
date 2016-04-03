//
//  LoginVC.swift
//  esc
//
//  Created by Rebecca Shaw on 3/30/16.
//  Copyright © 2016 Rebecca Shaw. All rights reserved.
//

//import Cocoa
import UIKit

class LoginVC: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        let ref = Firebase(url: "https://escapp.firebaseio.com")
        ref.observeAuthEventWithBlock({ authData in
            if authData != nil {
                // user authenticated
                self.performSegueWithIdentifier("goto_esc", sender: nil)
            } else {
                // No user is signed in
            }
        })
    }

    @IBAction func signinTapped(sender: UIButton)  {
        let ref = Firebase(url: "https://escapp.firebaseio.com")
        
        ref.authUser(email.text, password: password.text) {
            error, authData in
            if error != nil {
                // an error occured while attempting login
                let alertController = UIAlertController(title: "sign in", message:
                    "failed", preferredStyle: UIAlertControllerStyle.Alert)
                alertController.addAction(UIAlertAction(title: "try again", style: UIAlertActionStyle.Default,handler: nil))
                
                self.presentViewController(alertController, animated: true, completion: nil)
            } else {
                // user is logged in, check authData for data
            }
        }
    }
}

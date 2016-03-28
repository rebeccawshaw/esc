//
//  ViewController.swift
//  esc
//
//  Created by Rebecca Shaw on 3/19/16.
//  Copyright © 2016 Rebecca Shaw. All rights reserved.
//

import UIKit

class ViewController: UIViewController, GIDSignInUIDelegate {

    @IBOutlet weak var signInButton: GIDSignInButton!
    @IBOutlet weak var signOutButton: UIButton!
    @IBOutlet weak var eatButton: UIButton!
    @IBOutlet weak var studyButton: UIButton!
    @IBOutlet weak var chillButton: UIButton!
    @IBOutlet weak var statusText: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        GIDSignIn.sharedInstance().uiDelegate = self
        
        // Uncomment to automatically sign in the user.
        GIDSignIn.sharedInstance().signInSilently()
        
        // TODO(developer) Configure the sign-in button look/feel
        // [START_EXCLUDE]
        
        NSNotificationCenter.defaultCenter().addObserver(self,
            selector: "receiveToggleAuthUINotification:",
            name: "ToggleAuthUINotification",
            object: nil)
        
        toggleAuthUI()
    }
    
    @IBAction func didTapSignOut(sender: UIButton) {
        GIDSignIn.sharedInstance().signOut()
        statusText.text = "signed out"
        toggleAuthUI()
    }

    func toggleAuthUI() {
        if (GIDSignIn.sharedInstance().hasAuthInKeychain()){
            // Signed in
            signInButton.hidden = true
            signOutButton.hidden = false
            eatButton.hidden = false
            studyButton.hidden = false
            chillButton.hidden = false
        } else {
            signInButton.hidden = false
            signOutButton.hidden = true
            eatButton.hidden = true
            studyButton.hidden = true
            chillButton.hidden = true
            statusText.text = "esc"
        }
    }
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self,
            name: "ToggleAuthUINotification",
            object: nil)
    }
    
    @objc func receiveToggleAuthUINotification(notification: NSNotification) {
        if (notification.name == "ToggleAuthUINotification") {
            self.toggleAuthUI()
            if notification.userInfo != nil {
                let userInfo:Dictionary<String,String!> =
                notification.userInfo as! Dictionary<String,String!>
                self.statusText.text = userInfo["statusText"]
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}


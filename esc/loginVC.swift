//
//  loginVC.swift
//  esc
//
//  Created by Rebecca Shaw on 3/30/16.
//  Copyright © 2016 Rebecca Shaw. All rights reserved.
//

//import Cocoa
import UIKit

class loginVC: UIViewController {
    
    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signInTapped(sender: UIButton) {
        let ref = Firebase(url: "https://escapp.firebaseio.com")
        ref.authUser(email.text, password: password.text,
            withCompletionBlock: { error, authData in
                if error != nil {
                    // There was an error logging in to this account
                    let alertController = UIAlertController(title: "sign in", message:
                        "failed", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "try again", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                } else {
                    // We are now logged in
                }
        })
    }
}

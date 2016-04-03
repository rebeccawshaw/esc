//
//  signupVC.swift
//  esc
//
//  Created by Rebecca Shaw on 3/30/16.
//  Copyright © 2016 Rebecca Shaw. All rights reserved.
//

//import Cocoa
import UIKit

class SignupVC: UIViewController {

    @IBOutlet weak var email: UITextField!
    @IBOutlet weak var password: UITextField!
    @IBOutlet weak var confirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpTapped(sender: UIButton) {
        
        let ref = Firebase(url: "https://escapp.firebaseio.com")
        
        if (email.text != "" && password.text != "" && password.text == confirmPassword.text) {
            ref.createUser(email.text, password: password.text) { (error: NSError!) in
                if error == nil {
                    ref.authUser(self.email.text, password: self.password.text) {
                        error, authData in
                        if error != nil {
                            // Something went wrong. :(
                            let alertController = UIAlertController(title: "auth user", message:
                                "failed", preferredStyle: UIAlertControllerStyle.Alert)
                            alertController.addAction(UIAlertAction(title: "try again", style: UIAlertActionStyle.Default,handler: nil))
                        } else {
                            // Authentication just completed successfully :)

                            // Create a child path with a key set to the uid underneath the "users" node
                            // This creates a URL path like the following:
                            //  - https://<YOUR-FIREBASE-APP>.firebaseio.com/users/<uid>
                            ref.childByAppendingPath(authData.uid)
                        }
                    }
                    
                    self.view.window?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    let alertController = UIAlertController(title: "create user", message:
                        "failed", preferredStyle: UIAlertControllerStyle.Alert)
                    alertController.addAction(UIAlertAction(title: "try again", style: UIAlertActionStyle.Default,handler: nil))
                    
                    self.presentViewController(alertController, animated: true, completion: nil)
                }
            }
        } else {
            let alertController = UIAlertController(title: "sign up", message:
                "failed", preferredStyle: UIAlertControllerStyle.Alert)
            alertController.addAction(UIAlertAction(title: "try again", style: UIAlertActionStyle.Default,handler: nil))
            
            self.presentViewController(alertController, animated: true, completion: nil)
        }
    }
    
    @IBAction func gotoLogin(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

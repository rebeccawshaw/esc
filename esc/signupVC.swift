//
//  signupVC.swift
//  esc
//
//  Created by Rebecca Shaw on 3/30/16.
//  Copyright © 2016 Rebecca Shaw. All rights reserved.
//

//import Cocoa
import UIKit

class signupVC: UIViewController {

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
        
        if (email.text != "" && password.text != "" && password.text != confirmPassword.text) {
            
            let ref = Firebase(url: "https://escapp.firebaseio.com")
            ref.createUser(email.text, password: password.text,
                withValueCompletionBlock: { error, result in
                    if error != nil {
                        // There was an error creating the account
                        let alertController = UIAlertController(title: "sign up", message:
                            "error", preferredStyle: UIAlertControllerStyle.Alert)
                        alertController.addAction(UIAlertAction(title: "try again", style: UIAlertActionStyle.Default,handler: nil))
                        
                        self.presentViewController(alertController, animated: true, completion: nil)
                    } else {
                        let uid = result["uid"] as? String
                    }
            })
            
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

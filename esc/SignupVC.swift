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

    @IBOutlet weak var _email: UITextField!
    @IBOutlet weak var _username: UITextField!
    @IBOutlet weak var _password: UITextField!
    @IBOutlet weak var _confirmPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func signUpTapped(sender: UIButton) {
        
        let email = _email.text
        let username = _username.text
        let password = _password.text
        let confirmPassword = _confirmPassword.text
        
        // check for valid input
        if (email != "" && username != "" && password != "" && password == confirmPassword) {
            
            // create user
            DataService.dataService.BASE_REF.createUser(email, password: password) { (error: NSError!) in
                if error == nil {
                    
                    // authenticate user
                    DataService.dataService.BASE_REF.authUser(email, password: password) {
                        error, authData in
                        if error != nil {
                            // Something went wrong. :(
                            self.errorAlert("auth user", message: "failed", button: "try again")
                        } else {
                            // Authentication just completed successfully :)
                            let emailDict = ["email": email!]
                            DataService.dataService.createNewAccount(authData.uid, email: emailDict, username: username!)
                        }
                    }
                    
                    self.view.window?.rootViewController?.dismissViewControllerAnimated(true, completion: nil)
                } else {
                    self.errorAlert("create user", message: "failed", button: "try again")
                }
            }
        } else {
            errorAlert("sign up", message: "failed", button: "try again")
        }
    }
    
    // display error in signup
    func errorAlert(title: String, message: String, button: String) {
        let alertController = UIAlertController(title: title, message:
            message, preferredStyle: UIAlertControllerStyle.Alert)
        alertController.addAction(UIAlertAction(title: button, style: UIAlertActionStyle.Default,handler: nil))
        
        self.presentViewController(alertController, animated: true, completion: nil)
    }
    
    @IBAction func gotoLogin(sender: UIButton) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
}

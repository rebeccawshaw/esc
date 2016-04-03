//
//  DateVC.swift
//  esc
//
//  Created by Rebecca Shaw on 3/20/16.
//  Copyright © 2016 Rebecca Shaw. All rights reserved.
//

//import Cocoa
import UIKit

class TimeVC: UIViewController {

    @IBOutlet weak var pickTime: UIDatePicker!
    var time: NSDate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func setTimeTapped(sender: UIButton) {
        self.performSegueWithIdentifier("goto_loc", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goto_loc" {
            let ref = Firebase(url: "https://escapp.firebaseio.com")
            let uid = ref.authData.uid
            let userRef = Firebase(url: "https://escapp.firebaseio.com/\(uid)")
            let tm: [String: AnyObject!] = ["time": time]
            userRef.updateChildValues(tm)
            
            var locationVC = segue.destinationViewController as! LocationVC
            locationVC.time = pickTime.date
        }
    }
}
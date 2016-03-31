//
//  DateVC.swift
//  esc
//
//  Created by Rebecca Shaw on 3/20/16.
//  Copyright © 2016 Rebecca Shaw. All rights reserved.
//

//import Cocoa
import UIKit

class DateVC: UIViewController {

    @IBOutlet weak var pickTime: UIDatePicker!
    
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
            var locationVC = segue.destinationViewController as! LocationVC
            locationVC.time = pickTime.date
        }
    }
}
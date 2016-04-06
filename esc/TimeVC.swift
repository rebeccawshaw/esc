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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func setTimeTapped(sender: UIButton) {
        let timeFormatter = NSDateFormatter()
        timeFormatter.dateFormat = "hh:mm a"
        let strTime = timeFormatter.stringFromDate(pickTime.date)
        
        let tm: [String: AnyObject!] = ["time": strTime]
        DataService.dataService.DATA_REF.updateChildValues(tm)
        
        self.performSegueWithIdentifier("goto_loc", sender: self)
    }
}
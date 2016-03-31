//
//  MainVC.swift
//  esc
//
//  Created by Rebecca Shaw on 3/30/16.
//  Copyright © 2016 Rebecca Shaw. All rights reserved.
//

//import Cocoa
import UIKit

class MainVC: UIViewController {
    
    @IBOutlet weak var countdownLabel: UILabel!
    @IBOutlet weak var locationLabel: UILabel!
    
    var location: String?
    var time: NSDate?
    var timer: NSTimer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //countdownLabel.text = time!
        locationLabel.text = location!
        
        timer = NSTimer.scheduledTimerWithTimeInterval(1, target:self, selector: "updateProfile", userInfo: nil, repeats: true)
    }
    
    func updateProfile () {
        if (time?.timeIntervalSinceNow > 0) {
            //valid
        } else {
            //offline
            timer?.invalidate()
        }
    }
}

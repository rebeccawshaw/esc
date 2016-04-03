//
//  LocationVC.swift
//  esc
//
//  Created by Rebecca Shaw on 3/20/16.
//  Copyright © 2016 Rebecca Shaw. All rights reserved.
//

//import Cocoa
import UIKit

class LocationVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    @IBOutlet weak var pickLocation: UIPickerView!
    
    var pickLocationOptions: [String] = [String]()
    var time: NSDate?
    var location: NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickLocation.delegate = self
        self.pickLocation.dataSource = self
        
        pickLocationOptions = ["Commons", "Featheringill", "Rand", "Buttrick", "Stevenson"]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    // The number of columns of data
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    // The number of rows of data
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickLocationOptions.count
    }
    
    // The data to return for the row and component (column) that's being passed in
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return pickLocationOptions[row]
    }
    
    // Catpure the picker view selection
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        // This method is triggered whenever the user makes a change to the picker selection.
        // The parameter named row and component represents what was selected.
        location = pickLocationOptions[row]
    }
    
    @IBAction func setLocationTapped(sender: UIButton) {
        // Create a new user dictionary accessing the user's info
        // provided by the authData parameter
        let ref = Firebase(url: "https://escapp.firebaseio.com")
        let uid = ref.authData.uid
        let userRef = Firebase(url: "https://escapp.firebaseio.com/\(uid)")
        let loc: [String: AnyObject!] = ["location": location]
        userRef.updateChildValues(loc)
        
        self.performSegueWithIdentifier("goto_main", sender: self)
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "goto_main" {
            var mainVC = segue.destinationViewController as! MainVC
            mainVC.time = time
        }
    }
}

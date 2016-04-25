//
//  ViewController.swift
//  esc
//
//  Created by Rebecca Shaw on 3/19/16.
//  Copyright © 2016 Rebecca Shaw. All rights reserved.
//

import UIKit

class escVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    // MARK: Properties
    @IBOutlet weak var eatButton: UIButton!
    @IBOutlet weak var studyButton: UIButton!
    @IBOutlet weak var chillButton: UIButton!
    @IBOutlet weak var pickTime: UIDatePicker!
    @IBOutlet weak var pickLocation: UIPickerView!
    
    // MARK: Navigation
    @IBOutlet weak var saveButton: UIBarButtonItem!    
    
    var esc: NSString?
    var pickLocationOptions: [String] = [String]()
    var location: NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // disables save button initially
        saveButton.enabled = false
        
        self.pickLocation.delegate = self
        self.pickLocation.dataSource = self
        
        // sets items for location selection
        pickLocationOptions = ["Commons", "Featheringill", "Rand", "Buttrick", "Stevenson"]
        
        // default value for location - first item on picker view
        location = pickLocationOptions[0]
    }
    
    // cancels the view controller without changing any data
    @IBAction func cancelTapped(sender: UIBarButtonItem) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    // parameters for esc buttons

    // esc buttons to tap
    @IBAction func eatTapped(sender: UIButton) {
        esc = "eat"
        eatButton.backgroundColor = UIColor.grayColor()
        studyButton.backgroundColor = UIColor.blackColor()
        chillButton.backgroundColor = UIColor.blackColor()
        saveButton.enabled = true
    }
    
    @IBAction func studyTapped(sender: UIButton) {
        esc = "study"
        eatButton.backgroundColor = UIColor.blackColor()
        studyButton.backgroundColor = UIColor.grayColor()
        chillButton.backgroundColor = UIColor.blackColor()
        saveButton.enabled = true
    }
    
    @IBAction func chillTapped(sender: UIButton) {
        esc = "chill"
        eatButton.backgroundColor = UIColor.blackColor()
        studyButton.backgroundColor = UIColor.blackColor()
        chillButton.backgroundColor = UIColor.grayColor()
        saveButton.enabled = true
    }
    
    
    // parameters for the location picker view
    
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
}


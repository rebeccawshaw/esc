//
//  ViewController.swift
//  esc
//
//  Created by Rebecca Shaw on 3/19/16.
//  Copyright © 2016 Rebecca Shaw. All rights reserved.
//

import UIKit

class escVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    @IBOutlet weak var eatButton: UIButton!
    @IBOutlet weak var studyButton: UIButton!
    @IBOutlet weak var chillButton: UIButton!
    @IBOutlet weak var saveButton: UIBarButtonItem!
    @IBOutlet weak var pickTime: UIDatePicker!
    @IBOutlet weak var pickLocation: UIPickerView!
    
    var esc: NSString?
    var pickLocationOptions: [String] = [String]()
    var location: NSString?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.pickLocation.delegate = self
        self.pickLocation.dataSource = self
        
        // default value for esc - gets existing data
        DataService.dataService.DATA_REF.observeEventType(.Value, withBlock: { snapshot in
            self.esc = snapshot.value.objectForKey("esc") as! String
        })
        
        // sets items for location selection
        pickLocationOptions = ["Commons", "Featheringill", "Rand", "Buttrick", "Stevenson"]
        
        // default value for location - first item on picker view
        location = pickLocationOptions[0]
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // esc buttons to tap
    @IBAction func eatTapped(sender: UIButton) {
        esc = "eat"
        eatButton.backgroundColor = UIColor.grayColor()
        studyButton.backgroundColor = UIColor.blackColor()
        chillButton.backgroundColor = UIColor.blackColor()
    }
    
    @IBAction func studyTapped(sender: UIButton) {
        esc = "study"
        eatButton.backgroundColor = UIColor.blackColor()
        studyButton.backgroundColor = UIColor.grayColor()
        chillButton.backgroundColor = UIColor.blackColor()
    }
    
    @IBAction func chillTapped(sender: UIButton) {
        esc = "chill"
        eatButton.backgroundColor = UIColor.blackColor()
        studyButton.backgroundColor = UIColor.blackColor()
        chillButton.backgroundColor = UIColor.grayColor()
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
}


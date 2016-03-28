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
}

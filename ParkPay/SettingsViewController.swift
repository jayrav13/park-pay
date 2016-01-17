//
//  SettingsViewController.swift
//  ParkPay
//
//  Created by Jay Ravaliya on 1/16/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController : UITableViewController, UITableViewDelegate, UITableViewDataSource {
    
    var cars : [NSDictionary]!
    var payments : [NSDictionary]!
    
//    var carMakeCell : UITableViewCell = UITableViewCell()
//    var carModelCell : UITableViewCell = UITableViewCell()
//    var paymentCell : UITableViewCell = UITableViewCell()
//    
//    var carMakeText : UITextField = UITextField()
//    var carModelText : UITextField = UITextField()
//    var paymentText : UITextField = UITextField()
    
    
    override func loadView() {
        super.loadView()
        
        // set the title
        self.title = "Settings"
        
//        // construct car make cell, section 0, row 1
//        self.carMakeCell.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 0.5)
//        self.carMakeText = UITextField(frame: CGRectInset(self.carMakeCell.contentView.bounds, 30, 0))
//        self.carMakeText.placeholder = "Car Make"
//        self.carMakeCell.addSubview(self.carMakeText)
//        
//        // construct car model cell, section 0, row 1
//        self.carModelCell.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 0.5)
//        self.carModelText = UITextField(frame: CGRectInset(self.carMakeCell.contentView.bounds, 30, 0))
//        self.carModelText.placeholder = "Car Model"
//        self.carModelCell.addSubview(self.carModelText)
//        
//        // construct payment cell, section 1, row 0
//        self.paymentCell.textLabel?.text = "Share with Friends"
//        self.paymentCell.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 0.5)
//        self.paymentCell.accessoryType = UITableViewCellAccessoryType.Checkmark
    }
    
    // Return the number of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    // Return the number of rows for each section in your static table
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0: cars.count // section 0 has X rows equal to the number of cars
        case 1: payments.count    // section 1 has 1 row
        default: fatalError("Unknown number of sections")
        }
    }
    
    // Return the row for the corresponding section and row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        switch(indexPath.section) {
        case 0:
            switch(indexPath.row) {
            case 0: return self.carMakeCell     // section 0, row 0 is the car make
            case 1: return self.carModelCell    // section 0, row 1 is the car model
            default: fatalError("Unknown row in section 0")
            }
        case 1:
            switch(indexPath.row) {
            case 0: return self.paymentCell     // section 1, row 0 is the payment option
            default: fatalError("Unknown row in section 1")
            }
        default: fatalError("Unknown section")
        }
    }
    
    // Customize the section headings for each section
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
        case 0: return "Cars"
        case 1: return "Payments"
        default: fatalError("Unknown section")
        }
    }
    
    // Configure the row selection code for any cells that you want to customize the row selection
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
//        // deselect row
//        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
        
        // Handle social cell selection to toggle checkmark
        if(indexPath.section == 1 && indexPath.row == 0) {
            
            // deselect row
            tableView.deselectRowAtIndexPath(indexPath, animated: false)
            
            // toggle check mark
            if(self.paymentCell.accessoryType == UITableViewCellAccessoryType.None) {
                self.paymentCell.accessoryType = UITableViewCellAccessoryType.Checkmark;
            } else {
                self.paymentCell.accessoryType = UITableViewCellAccessoryType.None;
            }
        }
    }
    
}

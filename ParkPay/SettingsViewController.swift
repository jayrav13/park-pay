//
//  SettingsViewController.swift
//  ParkPay
//
//  Created by Jay Ravaliya on 1/16/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import UIKit

class SettingsViewController : UITableViewController {
    
    var cars : [NSDictionary]!
    var payments : [NSDictionary]!
    
    
    override func loadView() {
        super.loadView()
        
        // set the title
        self.title = "Settings"
        
        // registers cell
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    // Return the number of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    // Return the number of rows for each section in your static table
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0: return cars.count + 1          // section 0 has X rows equal to the number of cars
        case 1: return payments.count + 1      // section 1 has 1 row
        default: fatalError("Unknown number of sections")
        }
    }
    
    // Return the row for the corresponding section and row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCellWithIdentifier("cell")
        switch(indexPath.section) {
        case 0:
            cell?.textLabel!.text = "Car " + String(indexPath.row)
        case 1:
            cell?.textLabel!.text = "Car " + String(indexPath.row)
        default: fatalError("Unknown section")
        }
        return cell!
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
        
        // deselect row
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
}
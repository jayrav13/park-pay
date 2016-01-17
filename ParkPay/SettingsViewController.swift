//
//  SettingsViewController.swift
//  ParkPay
//
//  Created by Jay Ravaliya on 1/16/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

class SettingsViewController : UITableViewController {
    
    var vehicles : [JSON]!
    var payments : [JSON]!
    
    override func loadView() {
        super.loadView()
        
        // set the title
        self.title = "Settings"
        
        // registers cell
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }
    
    override func viewDidAppear(_ animated: Bool) {
        API.getUserData { (success, data) -> Void in
            self.vehicles = data["user"]["vehicles"].array
            self.payments = data["user"]["cards"].array
            self.tableView.reloadData()
        }
    }
    
    // Return the number of sections
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 2
    }
    
    // Return the number of rows for each section in your static table
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch(section) {
        case 0: return self.vehicles.count + 1      // section 0 has X rows equal to the number of vehicles + 1
        case 1: return self.payments.count + 1      // section 1 has X rows equal to the number of payments + 1
        default: fatalError("Unknown number of sections")
        }
    }
    
    // Return the row for the corresponding section and row
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell")
        switch(indexPath.section) {
        case 0: if (indexPath.row < vehicles.count) {
            cell?.textLabel!.text = vehicles[indexPath.row]["make"].stringValue + " " + vehicles[indexPath.row]["model"].stringValue + " " + vehicles[indexPath.row]["year"].stringValue
        } else {
            cell?.textLabel!.text = "Add new vehicle"
        };
        case 1: if (indexPath.row < payments.count) {
            cell?.textLabel!.text = String(payments[indexPath.row]["number"])
        } else {
            cell?.textLabel!.text = "Add new payment method"
        };
        default: fatalError("Unknown section")
        }
        return cell!
    }
    
    // Customize the section headings for each section
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch(section) {
        case 0: return "Vehicles"
        case 1: return "Payments"
        default: fatalError("Unknown section")
        }
    }
    
    // Configure the row selection code for any cells that you want to customize the row selection
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if (indexPath.section == 0) {
            let vehiclesViewController : VehiclesEditViewController = VehiclesEditViewController()
            vehiclesViewController.vehicleIndex = indexPath.row
            if (indexPath.row < vehicles.count) {
                vehiclesViewController.make = self.vehicles[indexPath.row]["make"].stringValue
                vehiclesViewController.model = self.vehicles[indexPath.row]["model"].stringValue
                vehiclesViewController.year = self.vehicles[indexPath.row]["year"].stringValue
                vehiclesViewController.license = self.vehicles[indexPath.row]["license"].stringValue
            }
            self.navigationController?.pushViewController(vehiclesViewController, animated: true)
        } else {
            let paymentsViewController : PaymentsEditViewController = PaymentsEditViewController()
            paymentsViewController.paymentIndex = indexPath.row
            if (indexPath.row < payments.count) {
                paymentsViewController.name = payments[indexPath.row]["name"].stringValue
                paymentsViewController.number = payments[indexPath.row]["number"].stringValue
                paymentsViewController.cvv = payments[indexPath.row]["cvv"].stringValue
                paymentsViewController.exp = payments[indexPath.row]["expiration_date"].stringValue
            }
            self.navigationController?.pushViewController(paymentsViewController, animated: true)
        }
    }
    
}
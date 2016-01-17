//
//  VehiclesEditViewController.swift
//  ParkPay
//
//  Created by Alec Huang on 1/17/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

class VehiclesEditViewController : UIViewController {
    
    var doneButton : UIBarButtonItem!
    var vehicleIndex : Int!
    
    var make : String!
    var model : String!
    var year : String!
    var license : String!
    
    var makeText : UITextField!
    var modelText : UITextField!
    var yearText : UITextField!
    var licenseText : UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Edit Vehicle"
        
        self.view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        
        self.doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "saveToSettingsViewController:")
        self.navigationItem.rightBarButtonItem = doneButton
        
        self.makeText = UITextField(frame: CGRect(x: Standard.screenWidth * 0.1, y: Standard.screenHeight * 0.1, width: Standard.screenWidth * 0.8, height: Standard.screenHeight * 0.1))
        self.makeText.placeholder = "Vehicle Make"
        if (self.makeText.text != nil) {
            self.makeText.text = make
        }
        self.view.addSubview(makeText)
        
        self.modelText = UITextField(frame: CGRect(x: Standard.screenWidth * 0.1, y: Standard.screenHeight * 0.2, width: Standard.screenWidth * 0.8, height: Standard.screenHeight * 0.1))
        self.modelText.placeholder = "Vehicle Model"
        if (self.modelText.text != nil) {
            self.modelText.text = model
        }
        self.view.addSubview(modelText)
        
        self.yearText = UITextField(frame: CGRect(x: Standard.screenWidth * 0.1, y: Standard.screenHeight * 0.3, width: Standard.screenWidth * 0.8, height: Standard.screenHeight * 0.1))
        self.yearText.placeholder = "Year"
        if (self.yearText.text != nil) {
            self.yearText.text = year
        }
        self.view.addSubview(yearText)
        
        self.licenseText = UITextField(frame: CGRect(x: Standard.screenWidth * 0.1, y: Standard.screenHeight * 0.4, width: Standard.screenWidth * 0.8, height: Standard.screenHeight * 0.1))
        self.licenseText.placeholder = "License Plate Number"
        if (self.licenseText.text != nil) {
            self.licenseText.text = license
        }
        self.view.addSubview(licenseText)
    }
    
    func saveToSettingsViewController(sender : UIButton) {
        API.postNewVehicle(self.makeText.text!, modelName: self.modelText.text!, year: self.yearText.text!, license: self.licenseText.text!) { (success, data) -> Void in
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
}
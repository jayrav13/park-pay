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
    var cancelButton : UIBarButtonItem!
    
    var makeText : UITextField!
    var modelText : UITextField!
    var licenseText : UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Edit Vehicle"
        
        self.view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        
        self.doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "saveToSettingsViewController:")
        self.navigationItem.leftBarButtonItem = doneButton
        
        self.makeText = UITextField(frame: CGRect(x: Standard.screenWidth * 0.1, y: Standard.screenHeight * 0.2, width: Standard.screenWidth * 0.8, height: Standard.screenHeight * 0.15))
        self.makeText.textAlignment = NSTextAlignment.Center
        self.modelText = UITextField(frame: CGRect(x: Standard.screenWidth * 0.1, y: Standard.screenHeight * 0.4, width: Standard.screenWidth * 0.8, height: Standard.screenHeight * 0.15))
        self.modelText.textAlignment = NSTextAlignment.Center
        self.licenseText = UITextField(frame: CGRect(x: Standard.screenWidth * 0.1, y: Standard.screenHeight * 0.6, width: Standard.screenWidth * 0.8, height: Standard.screenHeight * 0.15))
        self.licenseText.textAlignment = NSTextAlignment.Center
    }
    
    func saveToSettingsViewController(sender : UIButton) {
        let settingsViewController : SettingsViewController = SettingsViewController()
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
    func cancelToSettingsViewController(sender : UIButton) {
        let settingsViewController : SettingsViewController = SettingsViewController()
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }
    
}
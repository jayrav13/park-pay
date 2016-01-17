//
//  PaymentsEditViewController.swift
//  ParkPay
//
//  Created by Alec Huang on 1/17/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import SwiftyJSON
import UIKit

class PaymentsEditViewController : UIViewController {
    
    var doneButton : UIBarButtonItem!
    var cancelButton : UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Edit Vehicle"
        
        self.view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        
        self.doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "saveToSettingsViewController:")
        self.navigationItem.leftBarButtonItem = doneButton
        
        self.cancelButton = UIBarButtonItem(title: "Cancel", style: UIBarButtonItemStyle.Plain, target: self, action: "cancelToSettingsViewController:")
        self.navigationItem.leftBarButtonItem = cancelButton
        
        
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
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
    
    var name : String!
    var number : String!
    var cvv : String!
    var exp : String!
    
    var nameText : UITextField!
    var numberText : UITextField!
    var cvvText : UITextField!
    var expText : UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = "Edit Vehicle"
        
        self.view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        
        self.doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItemStyle.Plain, target: self, action: "saveToSettingsViewController:")
        self.navigationItem.rightBarButtonItem = doneButton
        
        self.nameText = UITextField(frame: CGRect(x: Standard.screenWidth * 0.1, y: Standard.screenHeight * 0.1, width: Standard.screenWidth * 0.8, height: Standard.screenHeight * 0.1))
        self.nameText.placeholder = "Cardholder Name"
        if (self.name != nil) {
            self.nameText.text = name
        }
        self.view.addSubview(nameText)
        
        self.numberText = UITextField(frame: CGRect(x: Standard.screenWidth * 0.1, y: Standard.screenHeight * 0.2, width: Standard.screenWidth * 0.8, height: Standard.screenHeight * 0.1))
        self.numberText.placeholder = "Card Number"
        if (self.number != nil) {
            self.numberText.text = number
        }
        self.view.addSubview(numberText)
        
        self.cvvText = UITextField(frame: CGRect(x: Standard.screenWidth * 0.1, y: Standard.screenHeight * 0.3, width: Standard.screenWidth * 0.8, height: Standard.screenHeight * 0.1))
        self.cvvText.placeholder = "CVV"
        if (self.cvv != nil) {
            self.cvvText.text = cvv
        }
        self.view.addSubview(cvvText)
        
        self.expText = UITextField(frame: CGRect(x: Standard.screenWidth * 0.1, y: Standard.screenHeight * 0.4, width: Standard.screenWidth * 0.8, height: Standard.screenHeight * 0.1))
        self.expText.placeholder = "Expiration Date YYYY-MM"
        if (self.exp != nil) {
            print("uh oh")
            let index = exp.startIndex.advancedBy(7)
            self.expText.text = exp.substringToIndex(index)
        }
        self.view.addSubview(expText)
        
    }
    
    func saveToSettingsViewController(sender : UIButton) {
        API.postNewPayment(self.nameText.text!, number: self.numberText.text!, cvv: self.cvvText.text!, expiration: (expText.text! + "-01")) { (success, data) -> Void in
            self.navigationController?.popViewControllerAnimated(true)
        }
    }
    
}
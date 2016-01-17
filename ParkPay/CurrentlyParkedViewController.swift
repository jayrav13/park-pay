//
//  CurrentlyParkedViewController.swift
//  ParkPay
//
//  Created by Jay Ravaliya on 1/17/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class CurrentlyParkedViewController : UIViewController {
    
    var currentlyParkedLabel : UILabel!
    var timeElapsedLabel : UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.currentlyParkedLabel = UILabel()
        self.currentlyParkedLabel.text = "Currently Parked"
        self.currentlyParkedLabel.font = UIFont.boldSystemFontOfSize(48)
        self.currentlyParkedLabel.frame = CGRect(x: 0, y: 0, width: Standard.screenWidth, height: Standard.screenHeight * 0.4)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    
}
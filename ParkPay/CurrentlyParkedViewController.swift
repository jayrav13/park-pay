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
    var relinquishButton : UIButton!
    var parkedValues : [Int]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.currentlyParkedLabel = UILabel()
        self.currentlyParkedLabel.text = "Currently Parked"
        self.currentlyParkedLabel.font = UIFont.boldSystemFontOfSize(42)
        self.currentlyParkedLabel.frame = CGRect(x: 0, y: 0, width: Standard.screenWidth, height: Standard.screenHeight * 0.4)
        self.currentlyParkedLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(self.currentlyParkedLabel)
        
        self.timeElapsedLabel = UILabel()
        self.timeElapsedLabel.text = "...time elapsed..."
        self.timeElapsedLabel.font = UIFont.boldSystemFontOfSize(32)
        self.timeElapsedLabel.frame = CGRect(x: 0, y: Standard.screenHeight * 0.45, width: Standard.screenWidth, height: Standard.screenHeight * 0.1)
        self.timeElapsedLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(self.timeElapsedLabel)
        
        self.relinquishButton = UIButton(type: UIButtonType.System)
        self.relinquishButton.setTitle("Relinquish Spot", forState: UIControlState.Normal)
        self.relinquishButton.addTarget(self, action: "relinquishSpot:", forControlEvents: UIControlEvents.TouchUpInside)
        self.relinquishButton.frame = CGRect(x: 0, y: Standard.screenHeight * 0.75, width: Standard.screenWidth, height: Standard.screenHeight * 0.1)
        self.relinquishButton.titleLabel?.font = UIFont.boldSystemFontOfSize(32)
        self.view.addSubview(self.relinquishButton)
        
        self.parkedValues = Standard.getUserParked()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func relinquishSpot(sender : UIButton) {
        
        API.postRelinquish(API.user_id, vehicleId: self.parkedValues[1]) { (success, data) -> Void in
            Standard.setUserParked([])
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                
            })
        }
    }
    
    
}
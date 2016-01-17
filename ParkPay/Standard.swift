//
//  Standard.swift
//  ParkPay
//
//  Created by Jay Ravaliya on 1/16/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import UIKit

class Standard {
    
    static var screenWidth : CGFloat = UIScreen.mainScreen().bounds.width
    static var screenHeight : CGFloat = UIScreen.mainScreen().bounds.height
    
    static func setUserParked(values : [Int]) {
        NSUserDefaults.standardUserDefaults().setObject(values, forKey: "userParked")
    }
    
    static func getUserParked() -> [Int] {
        if NSUserDefaults.standardUserDefaults().objectForKey("userParked") != nil {
            return NSUserDefaults.standardUserDefaults().objectForKey("userParked") as! [Int]
        }
        else {
            return []
        }
    }
    
    
    
}

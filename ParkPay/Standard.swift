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
    
    func hasVisited() -> Bool {
        return NSUserDefaults.standardUserDefaults().objectForKey("hasVisited") != nil
    }
    
}

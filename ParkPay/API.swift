//
//  API.swift
//  ParkPay
//
//  Created by Jay Ravaliya on 1/16/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import CoreLocation

class API {
    
    static var baseURL : String = "http://koolaid.ngrok.io/"
    
    static func getNearbyParkingLocations(latitude : CLLocationDegrees, longitude : CLLocationDegrees, completion : (success : Bool, data : JSON) -> Void) -> Void {

        Alamofire.request(Method.GET, self.baseURL + "parking").responseJSON { (response) -> Void in
            
            if response.result.isSuccess {
                completion(success: true, data: JSON(response.result.value!))
            }
            else {
                completion(success: false, data: nil)
            }
            
        }
        
    }
    
}

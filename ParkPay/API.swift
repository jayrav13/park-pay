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
    static var user_id : Int = 1
    
    static func getNearbyParkingLocations(completion : (success : Bool, data : JSON) -> Void) -> Void {
        
        Alamofire.request(Method.GET, self.baseURL + "parking").responseJSON { (response) -> Void in
            
            if response.result.isSuccess {
                completion(success: true, data: JSON(response.result.value!))
            }
            else {
                completion(success: false, data: nil)
            }
        }
    }
    
    static func getUserData(completion : (success : Bool, data : JSON) -> Void) -> Void {
        
        Alamofire.request(Method.GET, baseURL + "users/" + String(user_id)).responseJSON { (response) -> Void in
            
            if response.result.isSuccess {
                completion(success: true, data: JSON(response.result.value!))
            }
            else {
                completion(success: false, data: nil)
            }
            
        }
        
    }
    
    static func postClaim(parkingId : Int, vehicleId : Int, completion : (success : Bool, data : JSON) -> Void) -> Void {
        
        let parameters = [
            "user_id" : self.user_id,
            "parking_id" : parkingId,
            "vehicle_id" : vehicleId
        ]
        
        Alamofire.request(Method.POST, baseURL + "claim", parameters: parameters, encoding: ParameterEncoding.JSON, headers: nil).responseJSON { (response) -> Void in
            
            if response.result.isSuccess {
                completion(success: true, data: JSON(response.result.value!))
            }
            else {
                completion(success: false, data: nil)
            }
            
        }
        
    }
    
<<<<<<< HEAD
=======
    static func postRelinquish(parkingId : Int, vehicleId : Int, completion : (success : Bool, data : JSON) -> Void) -> Void {
        
        let parameters = [
            "user_id" : self.user_id,
            "parking_id" : parkingId,
            "vehicle_id" : vehicleId
        ]
        
        Alamofire.request(Method.POST, baseURL + "relinquish", parameters: parameters, encoding: ParameterEncoding.JSON, headers: nil).responseJSON { (response) -> Void in
            
            if response.result.isSuccess {
                completion(success: true, data: JSON(response.result.value!))
            }
            else {
                completion(success: false, data: nil)
            }
            
        }
        
    }
    
>>>>>>> 679c1c5c42cfaf55ee0f8960f2b239d571fb834d
    static func postNewVehicle(makeName : String, modelName : String, year : String, license : String, completion : (success : Bool, data : JSON) -> Void) -> Void {
        
        let parameters : [String : AnyObject] = [
            "user_id" : self.user_id,
            "make" : makeName,
            "model" : modelName,
            "year" : year,
            "license" : license
        ]
        
        Alamofire.request(Method.POST, baseURL + "vehicles", parameters: parameters, encoding: ParameterEncoding.JSON, headers: nil).responseJSON { (response) -> Void in
            
            if response.result.isSuccess {
                completion(success: true, data: JSON(response.result.value!))
            }
            else {
                completion(success: false, data: nil)
            }
            
        }
        
    }
    
    static func postNewPayment(name : String, number: String, cvv : String, expiration : String, completion : (success : Bool, data : JSON) -> Void) -> Void {
        
        let parameters : [String : AnyObject] = [
            "user_id" : self.user_id,
            "name" : name,
            "number" : number,
            "cvv" : cvv,
            "expiration_date" : expiration
        ]
        
        Alamofire.request(Method.POST, baseURL + "cards", parameters: parameters, encoding: ParameterEncoding.JSON, headers: nil).responseJSON { (response) -> Void in
            
            if response.result.isSuccess {
                completion(success: true, data: JSON(response.result.value!))
            }
            else {
                completion(success: false, data: nil)
            }
            
        }
        
    }
    
    static func getHistoricalPayments(completion : (success : Bool, data : JSON) -> Void) -> Void {
        
        Alamofire.request(Method.GET, baseURL + "payments/" + String(user_id)).responseJSON { (response) -> Void in
            
            if response.result.isSuccess {
                completion(success: true, data: JSON(response.result.value!))
            }
            else {
                completion(success: false, data: nil)
            }
            
        }
        
    }
    
    static func googleReverseGeocoding(latitude : CLLocationDegrees, longitude : CLLocationDegrees, completion : (success : Bool, data : JSON) -> Void) -> Void {
        
        let url = "https://maps.googleapis.com/maps/api/geocode/json"
        
        let parameters : [String : AnyObject] = [
            "latlng" : String(latitude) + "," + String(longitude),
            "key" : Secret.GoogleAPIKey
        ]
        
        Alamofire.request(Method.GET, url, parameters: parameters, encoding: ParameterEncoding.JSON, headers: nil).responseJSON { (response) -> Void in
            
            if response.result.isSuccess {
                completion(success: true, data: JSON(response.result.value!))
            }
            else {
                completion(success: false, data: nil)
            }
            
        }
        
    }
    
}

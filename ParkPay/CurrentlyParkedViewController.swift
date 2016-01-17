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
import MapKit

class CurrentlyParkedViewController : UIViewController, MKMapViewDelegate {
    
    var currentlyParkedLabel : UILabel!
    var timeElapsedLabel : UILabel!
    var relinquishButton : UIButton!
    var parkedValues : [Int]!
    
    var mapView : MKMapView!
    var currentParking : JSON!
    var locationPin : MKPointAnnotation!
    
    var cancelBarButtonItem : UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.whiteColor()
        
        self.currentlyParkedLabel = UILabel()
        self.currentlyParkedLabel.text = "Currently Parked"
        self.currentlyParkedLabel.font = UIFont.boldSystemFontOfSize(42)
        self.currentlyParkedLabel.frame = CGRect(x: 0, y: Standard.screenWidth * 0.1, width: Standard.screenWidth, height: Standard.screenHeight * 0.2)
        self.currentlyParkedLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(self.currentlyParkedLabel)
        
        self.timeElapsedLabel = UILabel()
        self.timeElapsedLabel.text = "...time elapsed..."
        self.timeElapsedLabel.font = UIFont.boldSystemFontOfSize(32)
        self.timeElapsedLabel.frame = CGRect(x: 0, y: Standard.screenHeight * 0.65, width: Standard.screenWidth, height: Standard.screenHeight * 0.1)
        self.timeElapsedLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(self.timeElapsedLabel)
        
        self.relinquishButton = UIButton(type: UIButtonType.System)
        self.relinquishButton.setTitle("Relinquish Spot", forState: UIControlState.Normal)
        self.relinquishButton.addTarget(self, action: "relinquishSpot:", forControlEvents: UIControlEvents.TouchUpInside)
        self.relinquishButton.frame = CGRect(x: 0, y: Standard.screenHeight * 0.75, width: Standard.screenWidth, height: Standard.screenHeight * 0.1)
        self.relinquishButton.titleLabel?.font = UIFont.boldSystemFontOfSize(32)
        self.view.addSubview(self.relinquishButton)
        
        self.getCurrentParkingData()
        self.timeElapsedLabel.text = JRDateFormatter("2016-01-17 12:23:49")
        
        self.cancelBarButtonItem = UIBarButtonItem(barButtonSystemItem: UIBarButtonSystemItem.Cancel, target: self, action: "cancelViewController:")
    }
    
    func cancelViewController(sender : UIButton) {
        self.dismissViewControllerAnimated(true) { () -> Void in
            
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func getCurrentParkingData() {
        API.getUserData { (success, data) -> Void in
            if success {
                self.currentParking = data["user"]["current_parking"]
                
                self.parkedValues = Standard.getUserParked()
                
                self.mapView = MKMapView(frame: CGRect(x: Standard.screenWidth * 0.1, y: Standard.screenHeight * 0.2, width: Standard.screenWidth * 0.8, height: Standard.screenHeight * 0.40))
                self.mapView.mapType = MKMapType.Standard
                self.mapView.zoomEnabled = true
                self.mapView.scrollEnabled = true
                self.mapView.delegate = self
                let coordinateRegion : MKCoordinateRegion = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: CLLocationDegrees(self.currentParking["latitude"].doubleValue), longitude: CLLocationDegrees(self.currentParking["longitude"].doubleValue)), span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
                
                self.locationPin = MKPointAnnotation()
                self.locationPin.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(self.currentParking["latitude"].doubleValue), CLLocationDegrees(self.currentParking["longitude"].doubleValue))
                self.locationPin.title = "Your Vehicle's Current Location"
                
                self.mapView.setRegion(coordinateRegion, animated: true)
                self.mapView.addAnnotation(self.locationPin)
                self.view.addSubview(self.mapView)
            }
            else {
                // Error
            }
        }
    }
    
    func relinquishSpot(sender : UIButton) {
        
        API.postRelinquish(API.user_id, vehicleId: self.parkedValues[1]) { (success, data) -> Void in
            Standard.setUserParked([])
            self.dismissViewControllerAnimated(true, completion: { () -> Void in
                
            })
        }
    }
    
    func JRDateFormatter(format : String) -> String {
        var dateFormatter : NSDateFormatter = NSDateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        var formerDate : NSDate = dateFormatter.dateFromString(format)!
        var seconds = Int(formerDate.timeIntervalSince1970 - NSDate(timeIntervalSinceNow: 0).timeIntervalSince1970) * -1
        
        var hours = 0
        var minutes = 0
        
        while seconds > 3600 {
            hours = hours + 1
            seconds = seconds - 3600
        }
        
        while seconds > 60 {
            minutes = minutes + 1
            seconds = seconds - 60
        }
        
        print(hours)
        print(minutes)
        print(seconds)
        return String(hours) + ":" + String(minutes) + ":" + String(seconds)
        
    }
    
    
}
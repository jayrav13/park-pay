//
//  ViewController.swift
//  ParkPay
//
//  Created by Jay Ravaliya on 1/16/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import UIKit
import CoreLocation
import MapKit
import SwiftyJSON

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate, UIPickerViewDelegate, UIPickerViewDataSource {

    // Location Manager
    var locationManager : CLLocationManager!
    var settingsBarButtonItem : UIBarButtonItem!
    
    // Labels
    var openSpotsLabel : UILabel!
    var payRateLabel : UILabel!
    
    // Buttons
    var parkButton : UIButton!
    var selectVehicleButton : UIButton!
    var selectPaymentButton : UIButton!
    
    // Maps
    var mapView : MKMapView!
    var allPins : [MKPointAnnotation]!
    
    // JSON
    var locationData : JSON!
    var userData : JSON!
    
    // Request
    var parkCarRequest : [Int]!
    
    // Picker View
    var pickerView : UIPickerView!
    var pickerViewIsVisible : Bool!
    var pickerViewTagSwitch : Int!
    var pickerViewData : [JSON]!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.view.backgroundColor = UIColor(red: 250/255, green: 250/255, blue: 250/255, alpha: 1)
        self.title = "Select a Spot"
        
        self.locationManager = CLLocationManager()
        self.locationManager.delegate = self
        self.locationManager.requestAlwaysAuthorization()
        self.locationManager.requestWhenInUseAuthorization()
        self.locationManager.startUpdatingLocation()
        
        self.settingsBarButtonItem = UIBarButtonItem(title: "Settings", style: UIBarButtonItemStyle.Plain, target: self, action: "pushToSettingsViewController:")
        self.navigationItem.rightBarButtonItem = settingsBarButtonItem
        
        self.mapView = MKMapView()
        self.mapView.frame = CGRect(x: 0, y: Standard.screenHeight * 0, width: Standard.screenWidth, height: Standard.screenHeight * 0.5)
        self.mapView.mapType = MKMapType.Standard
        self.mapView.zoomEnabled = true
        self.mapView.scrollEnabled = true
        self.mapView.delegate = self
        self.populateMap()
        self.setMapCenter()
        self.view.addSubview(mapView)
        
        self.openSpotsLabel = UILabel(frame: CGRect(x: 0, y: Standard.screenHeight * 0.55, width: Standard.screenWidth / 2, height: Standard.screenHeight * 0.05))
        self.openSpotsLabel.text = "...open spots..."
        self.openSpotsLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(self.openSpotsLabel)
        
        self.payRateLabel = UILabel(frame: CGRect(x: Standard.screenWidth / 2, y: Standard.screenHeight * 0.55, width: Standard.screenWidth / 2, height: Standard.screenHeight * 0.05))
        self.payRateLabel.text = "...pay rate ..."
        self.payRateLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(self.payRateLabel)
        
        self.selectVehicleButton = UIButton(type: UIButtonType.System)
        self.selectVehicleButton.setTitle("Pick Vehicle", forState: UIControlState.Normal)
        self.selectVehicleButton.addTarget(self, action: "selectVehicleButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.selectVehicleButton.frame = CGRect(x: 0, y: Standard.screenHeight * 0.65, width: Standard.screenWidth / 2, height: Standard.screenHeight * 0.05)
        self.view.addSubview(self.selectVehicleButton)
        
        self.selectPaymentButton = UIButton(type: UIButtonType.System)
        self.selectPaymentButton.setTitle("Pick Payment", forState: UIControlState.Normal)
        self.selectPaymentButton.addTarget(self, action: "selectPaymentButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.selectPaymentButton.frame = CGRect(x: Standard.screenWidth / 2, y: Standard.screenHeight * 0.65, width: Standard.screenWidth / 2, height: Standard.screenHeight * 0.05)
        self.view.addSubview(self.selectPaymentButton)
        
        self.parkButton = UIButton(type: UIButtonType.System)
        self.parkButton.frame = CGRect(x: Standard.screenWidth * 0.35, y: Standard.screenHeight * 0.80, width: Standard.screenWidth * 0.30, height: Standard.screenHeight * 0.075)
        self.parkButton.layer.cornerRadius = 10
        self.parkButton.clipsToBounds = true
        self.parkButton.setTitle("PARK", forState: UIControlState.Normal)
        
        self.parkButton.backgroundColor = UIColor(red: 63/255, green: 81/255, blue: 181/255, alpha: 1)
        self.parkButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        if(mapView.annotations.count == 0) {
            self.parkButton.alpha = 0.4
        }
        else {
            self.parkButton.addTarget(self, action: "parkButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        }
        
        self.parkButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 28)
        self.view.addSubview(self.parkButton)
        
        self.getUserData()
        self.pickerViewData = []
        self.pickerViewTagSwitch = 0
        
        self.pickerView = UIPickerView(frame: CGRect(x: 0, y: Standard.screenHeight, width: Standard.screenWidth, height: 216))
        self.pickerView.delegate = self
        self.pickerView.dataSource = self
        self.pickerView.backgroundColor = UIColor.whiteColor()
        self.pickerView.alpha = 1.0
        self.pickerView.opaque = false
        self.view.addSubview(pickerView)
        
        self.parkCarRequest = [0, 0, 0]
        self.pickerViewIsVisible = false
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        // print((manager.location?.coordinate.latitude)!)
    }
    
    func locationManager(manager: CLLocationManager, didChangeAuthorizationStatus status: CLAuthorizationStatus) {
        self.setMapCenter()
    }
    
    func pushToSettingsViewController(sender : UIButton) {
        let settingsViewController : SettingsViewController = SettingsViewController()
        settingsViewController.vehicles = self.userData["user"]["vehicles"].array
        settingsViewController.payments = self.userData["user"]["cards"].array
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }

    func setMapCenter() {
        let coordinateRegion : MKCoordinateRegion = MKCoordinateRegion(center: (self.locationManager.location?.coordinate)!, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        self.mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func populateMap() {
        if(CLLocationManager.locationServicesEnabled()) {
            API.getNearbyParkingLocations() { (success, data) -> Void in
                if success {
                    self.locationData = data
                    print(data)
                    for(var i = 0; i < data["parking"].count; i++) {
                        let locationPin = MKPointAnnotation()
                        locationPin.coordinate = CLLocationCoordinate2DMake(CLLocationDegrees(data["parking"][i]["latitude"].doubleValue), CLLocationDegrees(data["parking"][i]["longitude"].doubleValue))
                        locationPin.title = data["parking"][i]["street"].stringValue
                        self.mapView.addAnnotation(locationPin)
                    }
                    
                }
                else {
                    // Error message
                }
            }
        }
        
    }
    
    func parkButtonPressed(sender : UIButton) {
        API.postClaim(self.parkCarRequest[0], vehicleId: self.parkCarRequest[1]) { (success, data) -> Void in
            
        }
        print(self.parkCarRequest)
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        let thisAnnotation = mapView.selectedAnnotations[0]
        self.title = thisAnnotation.title!
        var selected : JSON = nil
        for(var i = 0; i < locationData["parking"].count; i++) {
            if(self.locationData["parking"][i]["street"].stringValue == thisAnnotation.title!) {
                selected = self.locationData["parking"][i]
                break
            }
        }
        if selected == nil {
            // error
            print("Error!")
        }
        else {
            self.parkCarRequest[0] = Int(selected["id"].doubleValue)
            self.openSpotsLabel.text = String(Int(selected["num_spots"].doubleValue)) + " spots available!"
            self.payRateLabel.text = "$" + String(selected["rate"].doubleValue) + " per hour"
        }
        
    }
    
    func selectVehicleButtonPressed(sender : UIButton) {
        self.pickerViewTagSwitch = 0
        self.pickerViewData = self.userData["user"]["vehicles"].array
        self.pickerView.reloadAllComponents()
        UIView.animateWithDuration(0.4, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            
            self.pickerView.frame = CGRect(x: 0, y: Standard.screenHeight - 216, width: Standard.screenWidth, height: 216)
            
            }) { (myBool : Bool) -> Void in
            
            self.pickerViewIsVisible = true
                
        }
    }
    
    func selectPaymentButtonPressed(sender : UIButton) {
        self.pickerViewTagSwitch = 1
        self.pickerViewData = self.userData["user"]["cards"].array
        self.pickerView.reloadAllComponents()
        UIView.animateWithDuration(0.4, delay: 0.0, options: UIViewAnimationOptions.CurveEaseIn, animations: { () -> Void in
            
            self.pickerView.frame = CGRect(x: 0, y: Standard.screenHeight - 216, width: Standard.screenWidth, height: 216)
            
            }) { (myBool : Bool) -> Void in
                
                self.pickerViewIsVisible = true
                
        }
    }
    
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerViewData.count
    }
    
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        if pickerViewTagSwitch == 0 {
            return pickerViewData[row]["make"].stringValue + " " + pickerViewData[row]["model"].stringValue
        }
        else {
            return (pickerViewData[row]["number"].stringValue as NSString).substringWithRange(NSRange(location: pickerViewData[row]["number"].stringValue.characters.count - 4, length: 4))
        }
    }
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if self.pickerViewTagSwitch == 0 {
            self.selectVehicleButton.setTitle(self.userData["user"]["vehicles"][row]["make"].stringValue + " " + self.userData["user"]["vehicles"][row]["model"].stringValue, forState: UIControlState.Normal)
            parkCarRequest[1] = row
            
        }
        else {
            parkCarRequest[2] = row
        }
    }
    
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        if(self.pickerViewIsVisible == true) {
            UIView.animateWithDuration(0.4, delay: 0, options: UIViewAnimationOptions.CurveEaseInOut, animations: { () -> Void in
                
                self.pickerView.frame = CGRect(x: 0, y: Standard.screenHeight, width: Standard.screenHeight, height: 216)
                
                }, completion: { (myBool : Bool) -> Void in
                    
                self.pickerViewIsVisible = false
                    
            })

        }
    }
    
    func getUserData() {
        API.getUserData { (success, data) -> Void in
            if success {
                self.userData = data
            }
            else {
                // Error
            }
        }
    }

}


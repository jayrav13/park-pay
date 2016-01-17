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

class ViewController: UIViewController, CLLocationManagerDelegate, MKMapViewDelegate {

    var locationManager : CLLocationManager!
    var settingsBarButtonItem : UIBarButtonItem!
    
    var openSpotsLabel : UILabel!
    var payRateLabel : UILabel!
    
    var parkButton : UIButton!
    
    var mapView : MKMapView!
    var allPins : [MKPointAnnotation]!
    
    var locationData : JSON!
    
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
        
        self.openSpotsLabel = UILabel(frame: CGRect(x: 0, y: Standard.screenHeight * 0.50, width: Standard.screenWidth / 2, height: Standard.screenHeight * 0.05))
        self.openSpotsLabel.text = "...open spots..."
        self.openSpotsLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(self.openSpotsLabel)
        
        self.payRateLabel = UILabel(frame: CGRect(x: Standard.screenWidth / 2, y: Standard.screenHeight * 0.50, width: Standard.screenWidth / 2, height: Standard.screenHeight * 0.05))
        self.payRateLabel.text = "...pay rate ..."
        self.payRateLabel.textAlignment = NSTextAlignment.Center
        self.view.addSubview(self.payRateLabel)
        
        self.parkButton = UIButton(type: UIButtonType.System)
        self.parkButton.frame = CGRect(x: Standard.screenWidth * 0.35, y: Standard.screenHeight * 0.60, width: Standard.screenWidth * 0.30, height: Standard.screenHeight * 0.075)
        self.parkButton.layer.cornerRadius = 10
        self.parkButton.clipsToBounds = true
        self.parkButton.setTitle("PARK", forState: UIControlState.Normal)
        self.parkButton.addTarget(self, action: "parkButtonPressed:", forControlEvents: UIControlEvents.TouchUpInside)
        self.parkButton.backgroundColor = UIColor(red: 63/255, green: 81/255, blue: 181/255, alpha: 1)
        self.parkButton.setTitleColor(UIColor.whiteColor(), forState: UIControlState.Normal)
        
        self.parkButton.titleLabel?.font = UIFont(name: "Helvetica Neue", size: 28)
        self.view.addSubview(self.parkButton)
        
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
        self.navigationController?.pushViewController(settingsViewController, animated: true)
    }

    func setMapCenter() {
        let coordinateRegion : MKCoordinateRegion = MKCoordinateRegion(center: (self.locationManager.location?.coordinate)!, span: MKCoordinateSpan(latitudeDelta: 0.1, longitudeDelta: 0.1))
        self.mapView.setRegion(coordinateRegion, animated: true)
    }
    
    func populateMap() {
        API.getNearbyParkingLocations((self.locationManager.location?.coordinate.latitude)!, longitude: (self.locationManager.location?.coordinate.longitude)!) { (success, data) -> Void in
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
    
    func parkButtonPressed(sender : UIButton) {
        
    }
    
    func mapView(mapView: MKMapView, didSelectAnnotationView view: MKAnnotationView) {
        self.title = mapView.selectedAnnotations[0].title!
    }

}


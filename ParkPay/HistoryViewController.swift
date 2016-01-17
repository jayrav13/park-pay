//
//  HistoryViewController.swift
//  ParkPay
//
//  Created by Jay Ravaliya on 1/17/16.
//  Copyright © 2016 JRav. All rights reserved.
//

import Foundation
import UIKit
import SwiftyJSON

class HistoryViewController : UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tableView : UITableView!
    var historicalData : JSON!
    var userData : JSON!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Balance: $ " + self.userData["user"]["balance"].stringValue.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        self.navigationController?.navigationBar.topItem!.title = ""
        self.view.backgroundColor = UIColor.whiteColor()
        self.tableView = UITableView()
        self.tableView.frame = self.view.frame
        self.tableView.dataSource = self
        self.tableView.delegate = self
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "cell")
        self.view.addSubview(tableView)
        
        self.historicalData = []
        
        self.getData()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell : UITableViewCell = self.tableView.dequeueReusableCellWithIdentifier("cell")!
        cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: "cell")
        cell.textLabel?.text = self.historicalData["payments"][indexPath.row]["time"].stringValue
        cell.detailTextLabel?.text = "$ " + self.historicalData["payments"][indexPath.row]["amount"].stringValue.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceCharacterSet())
        if self.historicalData["payments"][indexPath.row]["amount"].stringValue.containsString("-") {
            cell.detailTextLabel?.textColor = UIColor.greenColor()
        }
        else {
            cell.detailTextLabel?.textColor = UIColor.redColor()
        }
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        self.tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.historicalData["payments"].count
    }
    
    func getData() {
        
        API.getHistoricalPayments { (success, data) -> Void in
            if success {
                self.historicalData = data
                self.tableView.reloadData()
            }
        }
        
    }
    
}
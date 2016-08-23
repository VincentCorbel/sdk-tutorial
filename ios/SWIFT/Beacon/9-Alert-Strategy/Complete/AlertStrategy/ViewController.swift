//
//  ViewController.swift
//  AlertStrategy
//
//  Created by sarra srairi on 11/08/2016.
//  Copyright © 2016 R&D connecthings. All rights reserved.
//

import UIKit
import ATAnalytics
import ATLocationBeacon

class ViewController: UIViewController, ATBeaconAlertDelegate {
    
    @IBOutlet weak var txtAlertMessage: UILabel!
 
    @IBOutlet weak var actionTxt: UILabel!
    var currentAlertBeaconContent: ATBeaconContent!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alertTimeFilter: FirstWayAlertTimerStrategy = FirstWayAlertTimerStrategy(maxTime: 60 * 1, DelayAfterDetectingBeaconToCreateAlert: 30000)
        
        ATBeaconManager.sharedInstance().addAlertStrategy(alertTimeFilter)
        ATBeaconManager.sharedInstance().registerBeaconAlertDelgate(self)
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createBeaconAlert(_beaconContent: ATBeaconContent!) -> Bool {
        if ("popup" == _beaconContent.getAction()) {
            // create a popup view
            actionTxt.text = "Well done! now you have created your alert action"
            self.txtAlertMessage.text = _beaconContent.getAlertTitle()
            txtAlertMessage.setNeedsDisplay()
 
            currentAlertBeaconContent = _beaconContent
            return true
        }
        self.txtAlertMessage.text = "No Beacons ready for action"
        txtAlertMessage.setNeedsDisplay()
        return false

    }
    
    func removeBeaconAlert(_beaconContent: ATBeaconContent!, actionStatus _actionStatus: ATBeaconRemoveStatus) -> Bool {
        actionTxt.text = "Well done! now you have removed your alert action"
        self.txtAlertMessage.text = "Remove beacon alert action"
        txtAlertMessage.setNeedsDisplay()
        return true

    }
    
    func onNetworkError(_feedStatus: ATRangeFeedStatus) {
        
    }

}


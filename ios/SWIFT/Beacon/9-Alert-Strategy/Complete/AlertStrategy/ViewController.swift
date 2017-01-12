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
        ATBeaconManager.sharedInstance().registerBeaconAlertDelgate(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func createBeaconAlert(_ _beaconContent: ATBeaconContent!) -> Bool {
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
    
    func removeBeaconAlert(_ _beaconContent: ATBeaconContent!, actionStatus _actionStatus: ATBeaconRemoveStatus) -> Bool {
        actionTxt.text = "Well done! now you have removed your alert action"
        self.txtAlertMessage.text = "Remove beacon alert action"
        txtAlertMessage.setNeedsDisplay()
        return true
        
    }
    
    func onNetworkError(_ _feedStatus: ATRangeFeedStatus) {
        
    }
    
}


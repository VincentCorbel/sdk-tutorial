//
//  ViewController.swift
//  AlertStrategy
//
//  Created by sarra srairi on 11/08/2016.
//  Copyright © 2016 R&D connecthings. All rights reserved.
//

import UIKit
import ConnectPlaceActions
import AdtagAnalytics
import AdtagConnection
import AdtagLocationBeacon

class ViewController: UIViewController, AdtagInAppActionDelegate {
    @IBOutlet weak var txtAlertMessage: UILabel!
    @IBOutlet weak var actionTxt: UILabel!
    
    var currentPlaceInAppAction: PlaceInAppAction!
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        AdtagBeaconManager.shared.registerInAppActionDelegate(self)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated);
        AdtagBeaconManager.shared.unregisterInAppActionDelegate()
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createInAppAction(_ placeInAppAction: AdtagPlaceInAppAction, statusManager: InAppActionStatusManagerDelegate) -> Bool {
        if ("popup" == placeInAppAction.getAction()) {
            actionTxt.text = "Well done! now you have created your alert action"
            self.txtAlertMessage.text = placeInAppAction.getTitle()
            txtAlertMessage.setNeedsDisplay()
            currentPlaceInAppAction = placeInAppAction
            return true
        }
        self.txtAlertMessage.text = "No Beacons ready for action"
        txtAlertMessage.setNeedsDisplay()
        return false
    }
    
    func removeInAppAction(_ placeInAppAction: AdtagPlaceInAppAction, inAppActionRemoveStatus: InAppActionRemoveStatus) -> Bool {
        actionTxt.text = "Well done! now you have removed your alert action"
        self.txtAlertMessage.text = "Remove beacon alert action"
        txtAlertMessage.setNeedsDisplay()
        return true
    }
}

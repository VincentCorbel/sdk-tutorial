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
import ConnectPlaceCommon

class ViewController: UIViewController, AdtagInAppActionDelegate {
    @IBOutlet weak var txtAlertMessage: UILabel!
    @IBOutlet weak var buttonInAppAction: UIButton!
    
    var currentPlaceInAppAction: PlaceInAppAction!
  
    override func viewWillAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
        AdtagBeaconManager.shared.registerInAppActionDelegate(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewDidAppear(animated);
        AdtagBeaconManager.shared.unregisterInAppActionDelegate()
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func createInAppAction(_ placeInAppAction: AdtagPlaceInAppAction, statusManager: InAppActionStatusManagerDelegate) -> Bool {
        if ("popup" == placeInAppAction.getAction()) {
            GlobalLogger.shared.debug("Well done! now you have created your alert action")
            self.txtAlertMessage.text = placeInAppAction.getTitle()
            txtAlertMessage.setNeedsDisplay()
            buttonInAppAction.isHidden = false
            currentPlaceInAppAction = placeInAppAction
            return true
        }
        self.txtAlertMessage.text = "No Beacons ready for action"
        txtAlertMessage.setNeedsDisplay()
        return false
    }
    
    func removeInAppAction(_ placeInAppAction: AdtagPlaceInAppAction, inAppActionRemoveStatus: InAppActionRemoveStatus) -> Bool {
        GlobalLogger.shared.debug("Well done! now you have removed your alert action")
        buttonInAppAction.isHidden = true
        txtAlertMessage.text = "The In-App Action has been removed"
        txtAlertMessage.setNeedsDisplay()
        return true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let alertViewController = segue.destination as? AlertViewControllerAction {
            if let currentAdtagPlaceInAppAction = currentPlaceInAppAction as? AdtagPlaceInAppAction {
                alertViewController.currentPlaceInAppAction = currentAdtagPlaceInAppAction
            }
        }
    }
}

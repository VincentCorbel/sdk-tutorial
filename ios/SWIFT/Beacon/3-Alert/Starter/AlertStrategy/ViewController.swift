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

class ViewController: UIViewController {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let alertViewController = segue.destination as? AlertViewControllerAction {
            if let currentAdtagPlaceInAppAction = currentPlaceInAppAction as? AdtagPlaceInAppAction {
                alertViewController.currentPlaceInAppAction = currentAdtagPlaceInAppAction
            }
        }
    }
}

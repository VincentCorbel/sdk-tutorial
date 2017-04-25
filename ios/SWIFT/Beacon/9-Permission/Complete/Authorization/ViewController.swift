//
//  ViewController.swift
//  Authorization
//
//  Created by sarra srairi on 10/08/2016.
//  Copyright © 2016 R&D connecthings. All rights reserved.
//

import UIKit
import ATAnalytics
import ATLocationBeacon
import AVFoundation


class ViewController: UIViewController, ATBeaconBleLocationStatusDelegate {
    
    @IBOutlet weak var labelStatus: UILabel!
    
    
    override func viewDidAppear(_ animated: Bool) {
        
        super.viewDidAppear(animated)
        ATBeaconManager.sharedInstance().registerAdtagBeaconBleLocationDelegate(self)
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        ATBeaconManager.sharedInstance().registerAdtagBeaconBleLocationDelegate(nil)
    }
    
    
    func checkBleStatus(_ bleStatus: CBManagerState, locationStatus: CLAuthorizationStatus){
        
        if locationStatus == CLAuthorizationStatus.denied || locationStatus == CLAuthorizationStatus.restricted {
            self.labelStatus.text = "Please authorize the application to access to your location"
        }
        else if bleStatus == .unauthorized || bleStatus == .poweredOff {
            self.labelStatus.text = "Please activate bluetooth"
        }
        else if bleStatus == .unsupported {
            self.labelStatus.text = "The bluetooth is not supported on your phone"
        }
        else {
            self.labelStatus.text = "It's ready for beacon detection"
        }
        
        labelStatus.setNeedsDisplay()
    }
}


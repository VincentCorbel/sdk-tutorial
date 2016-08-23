//
//  ViewController.swift
//  beaconRange
//
//  Created by sarra srairi on 10/08/2016.
//  Copyright © 2016 R&D connecthings. All rights reserved.
//

import UIKit
import ATAnalytics
import ATLocationBeacon

class ViewController: UIViewController,ATRangeDelegate {
    
    @IBOutlet weak var txt_nbrBeacon: UILabel!
     var beaconManager: ATBeaconManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        beaconManager = ATBeaconManager.sharedInstance()
        beaconManager.registerAdtagRangeDelegate(self)
 
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

 func didRangeBeacons(beacons: [AnyObject], beaconContents: [AnyObject], informationStatus: ATRangeInformationStatus, feedStatus: ATRangeFeedStatus, region: CLRegion!) {
        var feedStatusString: String
        
        
        switch feedStatus {
        case ATRangeFeedStatusInProgress:
            feedStatusString = "IN_PROGRESS"
        case ATRangeFeedStatusBackendError:
            feedStatusString = "BACKEND_ERROR"
        case ATRangeFeedStatusNetworkError:
            feedStatusString = "NETWORK_ERROR"
        case ATRangeFeedStatusBackendSuccess:
            feedStatusString = "BACKEND_SUCCESS"
            default:
             feedStatusString = ""
        }
     
        
        self.txt_nbrBeacon.text = String(format: NSLocalizedString("beaconDetected", comment: ""), feedStatusString, beacons.count, beaconContents.count)

    
    }

}


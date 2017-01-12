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
    
    func didRangeBeacons(_ _beacons: [Any]!, beaconContents: [Any]!, informationStatus: ATRangeInformationStatus, feedStatus: ATRangeFeedStatus, region: CLRegion!) {
        var feedStatusString: String
        
 
    } 
}


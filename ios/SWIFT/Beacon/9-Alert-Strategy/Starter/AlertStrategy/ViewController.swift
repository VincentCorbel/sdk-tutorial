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

class ViewController: UIViewController {
    
    @IBOutlet weak var txtAlertMessage: UILabel!
 
    @IBOutlet weak var actionTxt: UILabel!
    var currentAlertBeaconContent: ATBeaconContent!
  
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let alertTimeFilter: FirstWayAlertTimerStrategy = FirstWayAlertTimerStrategy(maxTime: 60 * 1, DelayAfterDetectingBeaconToCreateAlert: 30000)
        

        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}


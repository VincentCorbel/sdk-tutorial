//
//  TimeAlertStrategyParameter.swift
//  AlertStrategy
//
//  Created by sarra srairi on 29/08/2016.
//  Copyright © 2016 R&D connecthings. All rights reserved.
//

import UIKit
import ATAnalytics
import ATLocationBeacon
import AVFoundation


class TimeAlertStrategyParameter : ATBeaconAlertParameter{

    var lastDetectionTime: Double!
    var timeToShowAlert: Double!
     
    override init() {
        super.init()
        lastDetectionTime = 0
        timeToShowAlert = 0
    }
    
}
 
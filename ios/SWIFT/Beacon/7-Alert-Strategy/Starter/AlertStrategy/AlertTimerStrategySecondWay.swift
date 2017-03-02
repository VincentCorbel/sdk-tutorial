//
//  AlertTimerStrategySecondWay.swift
//  AlertStrategy
//
//  Created by sarra srairi on 29/08/2016.
//  Copyright © 2016 R&D connecthings. All rights reserved.
//

import UIKit
import ATAnalytics
import ATLocationBeacon
import AVFoundation

class AlertTimerStrategySecondWay : ATBeaconAlertStrategy {
    var delayBeforeCreatingAlert: Double!
    
    
    init(maxTime maxTimeBeforeReset: Int, DelayAfterDetectingBeaconToCreateAlert _delayBeforeCreatingAlert: Int) {
        super.init(maxTime:((Double(maxTimeBeforeReset))))
        self.delayBeforeCreatingAlert = (Double(_delayBeforeCreatingAlert) / 1000.0)
        
    }
    
    override func getKey() -> String {
        return "timeAlertStrategy"
    }
    
    
    override func isConditionValid(_ _beaconParameter: ATBeaconAlertParameter!) -> Bool {
             /* Complete */
         }
 
    override func updateAlertParameter(_ _beaconContent: ATBeaconContent!) {
        let strategyParameter = _beaconContent.beaconAlertParameter as! TimeAlertStrategyParameter
        let currentTime: Double = CFAbsoluteTimeGetCurrent()
        
     /* Complete */
    }
    
 
    override func getBeaconAlertParameterClass() -> Any! {
       return  TimeAlertStrategyParameter.self
    }
 
}

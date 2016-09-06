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
    
    
    override func isConditionValid(_beaconParameter: ATBeaconAlertParameter!) -> Bool {
        let strategyParameter: TimeAlertStrategyParameter = (_beaconParameter  as! TimeAlertStrategyParameter)
 
        return strategyParameter.timeToShowAlert < CFAbsoluteTimeGetCurrent ()
    }
    
    
    
    override func updateBeaconContent(_beaconContent: ATBeaconContent!) {
        super.updateBeaconContent(_beaconContent)
        
        
        let strategyParameter = _beaconContent.beaconAlertParameter as! TimeAlertStrategyParameter
        let currentTime: Double = CFAbsoluteTimeGetCurrent()
        
        if(strategyParameter.lastDetectionTime + 3 < currentTime){
            print("delay before creating " , delayBeforeCreatingAlert)
            strategyParameter.timeToShowAlert = currentTime + delayBeforeCreatingAlert;
        }
        strategyParameter.lastDetectionTime = currentTime + 0 ;
        
    }
    
    override func getBeaconAlertParameterClass() -> AnyObject! {
        
        return  TimeAlertStrategyParameter.self
    }
}
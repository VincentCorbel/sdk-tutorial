//
//  FirstWayAlertTimerStrategy.swift
//  AlertStrategy
//
//  Created by sarra srairi on 11/08/2016.
//  Copyright © 2016 R&D connecthings. All rights reserved.
//

import UIKit
import ATAnalytics
import ATLocationBeacon
import AVFoundation


class FirstWayAlertTimerStrategy: NSObject, ATBeaconAlertStrategyDelegate {

var maxTimeBeforeReset: Double!
var timeToCreateAlert: Double!
    
init(maxTime maxTimeBeforeReset: Int, DelayAfterDetectingBeaconToCreateAlert timeToCreateAlert: Int) {
        super.init()
        
        self.maxTimeBeforeReset = (Double (maxTimeBeforeReset))
        self.timeToCreateAlert = (Double (timeToCreateAlert / 1000)) + CFAbsoluteTimeGetCurrent()
    }
    
    func getKey() -> String {
        return "timeAlertStrategy"
    }
    
    func isConditionValid(_beaconParameter: ATBeaconAlertParameter!) -> Bool {
       

    }
    
    
    func updateAlertParameter(beaconContent: ATBeaconContent) {

    }
    
    func isInProximityForAction(beaconContent: ATBeaconContent) -> Bool {
        if beaconContent.poi == nil {
            return false
        }
      
          var rangeString: String!
            rangeString = beaconContent.getRange()
        
        if rangeString != nil {
            
            NSLog("timeToCreateAlert %d",  timeToCreateAlert)
            NSLog("current time %f",  CFAbsoluteTimeGetCurrent())
            if beaconContent.beacon != nil && CFAbsoluteTimeGetCurrent() >= timeToCreateAlert {
                return true
            }
        }
        return false
    }
 
    func isReadyForAction(beaconParameter: ATBeaconAlertParameter) -> Bool {
        return (beaconParameter.actionStatus == ATBeaconActionStatusWaitingForAction && beaconParameter.isConditionValid)
    }
    
    
    func updateBeaconContent(beaconContent: ATBeaconContent) {
        
    }
    
    func createBeaconAlertParameter() -> ATBeaconAlertParameter {
        return (ATBeaconAlertParameter())
    }
    
    func testToReseatActionIsDone(strategyParameter: ATBeaconAlertParameter) {
        if (!strategyParameter.isConditionValid) || (strategyParameter.maxTimeBeforeResetingIsActionDone < Int(CFAbsoluteTimeGetCurrent()) && strategyParameter.actionStatus  == ATBeaconActionStatusActionDone) {
            strategyParameter.actionStatus = ATBeaconActionStatusWaitingForAction
        }
    }

}


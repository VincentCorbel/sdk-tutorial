//
//  AlertTimerStrategyFirstWay.swift
//  AlertStrategy
//
//  Created by sarra srairi on 29/08/2016.
//  Copyright © 2016 R&D connecthings. All rights reserved.
//

import UIKit
import ATAnalytics
import ATLocationBeacon
import AVFoundation

class AlertTimerStrategyFirstWay : NSObject, ATBeaconAlertStrategyDelegate {
    
    var maxTimeBeforeReset: Double!
    var delayBeforeCreatingAlert: Double!
    
         
    init(maxTime maxTimeBeforeReset: Int, DelayAfterDetectingBeaconToCreateAlert _delayBeforeCreatingAlert: Int) {
        super.init()
        
        self.maxTimeBeforeReset = Double (maxTimeBeforeReset)
        self.delayBeforeCreatingAlert = (Double (_delayBeforeCreatingAlert / 1000))
    }
    
    func getKey() -> String {
        return "timeAlertStrategy"
    }
    
    func isConditionValid(_ _beaconParameter: ATBeaconAlertParameter!) -> Bool {
             /* Complete */

    }
    
    
    func isReady(forAction _beaconParameter: ATBeaconAlertParameter!) -> Bool {
             /* Complete */
         }
    
    
    private func getBeaconAlertParameterClass() -> AnyObject! {
        
        let myObject: AnyObject = TimeAlertStrategyParameter()
        return  myObject
    }
    
 
    
    func update(_ _beaconContent: ATBeaconContent!){
        
        if (_beaconContent.beaconAlertParameter == nil ) {
            let stategy : TimeAlertStrategyParameter = self.getBeaconAlertParameterClass()  as! TimeAlertStrategyParameter
            _beaconContent.beaconAlertParameter = stategy
        }
        
        let strategyParameter = _beaconContent.beaconAlertParameter as! TimeAlertStrategyParameter
        let currentTime: Double = CFAbsoluteTimeGetCurrent()
        
        if(strategyParameter.lastDetectionTime + 3 < currentTime){
            strategyParameter.timeToShowAlert = currentTime + delayBeforeCreatingAlert;
        }
        strategyParameter.lastDetectionTime = currentTime + 0 ;
        
        _beaconContent.beaconAlertParameter.isConditionValid =  self.isConditionValid(_beaconContent.beaconAlertParameter);
        
        if (_beaconContent.beaconAlertParameter.actionStatus  == ATBeaconActionStatusActionDone){
            self.testToReseatActionIsDone(_beaconContent.beaconAlertParameter)
        }
 
        /* Complete */
    }

    
    func testToReseatActionIsDone(_ strategyParameter: ATBeaconAlertParameter) {
        
        if (!strategyParameter.isConditionValid) || (strategyParameter.maxTimeBeforeResetingIsActionDone < Int(CFAbsoluteTimeGetCurrent()) && strategyParameter.actionStatus  == ATBeaconActionStatusActionDone) {
            strategyParameter.actionStatus = ATBeaconActionStatusWaitingForAction
        }
    }
    
    
}

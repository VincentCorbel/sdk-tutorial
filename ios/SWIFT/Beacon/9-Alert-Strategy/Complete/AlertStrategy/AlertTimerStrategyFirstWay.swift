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
    
    func isConditionValid(_beaconParameter: ATBeaconAlertParameter!) -> Bool {
        
        let strategyParameter: TimeAlertStrategyParameter = (_beaconParameter  as! TimeAlertStrategyParameter)
        return strategyParameter.timeToShowAlert < CFAbsoluteTimeGetCurrent ()
    }
    
    
    func isReadyForAction(_beaconParameter: ATBeaconAlertParameter!) -> Bool {
        return (_beaconParameter.actionStatus == ATBeaconActionStatusWaitingForAction && _beaconParameter.isConditionValid)
        
    }
    
    
    func getBeaconAlertParameterClass() -> AnyObject! {
        
        let myObject: AnyObject = TimeAlertStrategyParameter()
        return  myObject
    }
    
    func updateBeaconContent(_beaconContent: ATBeaconContent!){
        
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
        
        _beaconContent.beaconAlertParameter.isReadyForAction =  self.isReadyForAction(_beaconContent.beaconAlertParameter);
        //Update each cycle -> means only a beacon that we don't see for more than maxTimeBeforeReset will be impact
        _beaconContent.beaconAlertParameter.maxTimeBeforeResetingIsActionDone =  Int (CFAbsoluteTimeGetCurrent() +  maxTimeBeforeReset)
        
    }
    
    func testToReseatActionIsDone(strategyParameter: ATBeaconAlertParameter) {
        
        if (!strategyParameter.isConditionValid) || (strategyParameter.maxTimeBeforeResetingIsActionDone < Int(CFAbsoluteTimeGetCurrent()) && strategyParameter.actionStatus  == ATBeaconActionStatusActionDone) {
            strategyParameter.actionStatus = ATBeaconActionStatusWaitingForAction
        }
    }
    
    
}
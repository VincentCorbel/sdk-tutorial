//
//  SecondWayAlertTimerStrategy.swift
//  AlertStrategy
//
//  Created by sarra srairi on 11/08/2016.
//  Copyright © 2016 R&D connecthings. All rights reserved.
//
import UIKit
import ATAnalytics
import ATLocationBeacon
import AVFoundation


class SecondWayAlertTimerStrategy: ATBeaconAlertStrategy {
    
    var timeToCreateAlert: Double!
    
    // The output below is limited by 1 KB.
    // Please Sign Up (Free!) to remove this limitation.
    
    
    init(maxTime maxTimeBeforeReset: Int, DelayAfterDetectingBeaconToCreateAlert timeToCreateAlert: Int) {
        super.init(maxTime: (Int32(maxTimeBeforeReset)))
        
        self.timeToCreateAlert = (Double(timeToCreateAlert) / 1000 )
 
 
    }
    
    override func getKey() -> String {
        return "timeAlertStrategy"
    }
    
    override func isConditionValid(_beaconParameter: ATBeaconAlertParameter!) -> Bool {
    
    }
    
    func isInProximityForAction(beaconContent: ATBeaconContent) -> Bool {
        if beaconContent.poi == nil {
            return false
        }
        
        var rangeString: String!
        rangeString = beaconContent.getRange()
        
        if rangeString.isEmpty  {
            if beaconContent.beacon != nil && CFAbsoluteTimeGetCurrent() >= timeToCreateAlert {
                return true
            }
        }
        return false
    }
    
    override func updateAlertParameter(beaconContent: ATBeaconContent) {
    
    }
    
    override func createBeaconAlertParameter() -> ATBeaconAlertParameter {
        return (ATBeaconAlertParameter())
    }
}
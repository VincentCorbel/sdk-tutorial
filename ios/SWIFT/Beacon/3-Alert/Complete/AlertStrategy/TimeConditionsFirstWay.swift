//
//  TimeConditionsFirstWay.swift
//  AlertStrategy
//
//  Created by Ludovic Vimont on 13/11/2017.
//  Copyright © 2017 R&D connecthings. All rights reserved.
//

import Foundation
import ConnectPlaceCommon
import ConnectPlaceActions

@objc public class TimeConditionsFirstWay: NSObject, InAppActionConditions {
    var maxTimeBeforeReset: Double
    var timeProvider: TimeProvider
    var delayBeforeCreation: Double
    
    public init(maxTimeBeforeReset: Double = 60, delayBeforeCreation: Int) {
        self.maxTimeBeforeReset = maxTimeBeforeReset
        self.timeProvider = TimeProviderAbsolute()
        self.delayBeforeCreation = (Double(delayBeforeCreation) / 1000.0)
    }
    
    public func getApplicationNamespace() -> String {
        return String(reflecting: TimeConditionsFirstWay.self).split(separator: ".")[0].description
    }
    
    public func getConditionsKey() -> String {
        return "timeConditionsFirstWay"
    }
    
    public func getInAppActionParameterClass() -> String {
        return "TimeConditionsParameter"
    }
    
    public func updateInAppActionConditionsParameter(_ conditionsParameter: InAppActionConditionsParameter) {
        if let strategyParameter = conditionsParameter as? TimeConditionsParameter {
            let currentTime: Double = CFAbsoluteTimeGetCurrent()
            if strategyParameter.lastDetectionTime + 3 < currentTime {
                print("delay before creating " , delayBeforeCreation)
                strategyParameter.timeToShowAlert = currentTime + delayBeforeCreation
            }
            strategyParameter.lastDetectionTime = currentTime + 0
        }
        if let strategyParameter = conditionsParameter as? TimeConditionsParameter {
            conditionsParameter.isConditionValid = strategyParameter.timeToShowAlert < CFAbsoluteTimeGetCurrent ()
        } else {
            conditionsParameter.isConditionValid = true
        }
        if conditionsParameter.inAppActionStatus == InAppActionStatus.DONE {
            if !conditionsParameter.isConditionValid
                || conditionsParameter.maxTimeBeforeActionDoneReset < timeProvider.getTime() {
                conditionsParameter.inAppActionStatus = InAppActionStatus.WAITING_FOR_ACTION
            }
        }
        conditionsParameter.isReadyForAction = conditionsParameter.inAppActionStatus == InAppActionStatus.WAITING_FOR_ACTION
            && conditionsParameter.isConditionValid
        conditionsParameter.maxTimeBeforeActionDoneReset = timeProvider.getTime() + maxTimeBeforeReset
    }
}



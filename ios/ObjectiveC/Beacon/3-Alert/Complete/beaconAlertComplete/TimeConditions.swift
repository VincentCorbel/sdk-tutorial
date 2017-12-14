//
//  TimeConditions.swift
//  beaconAlertComplete
//
//  Created by Connecthings on 14/11/2017.
//  Copyright © 2017 Connecthings. All rights reserved.
//

import Foundation
import ConnectPlaceActions
import ConnectPlaceCommon

public class TimeConditions: InAppActionConditionsDefault {
    @objc let delayBeforeCreation: Double
    
    public init(maxTimeBeforeReset: Double, delayBeforeCreation: Double) {
        self.delayBeforeCreation = delayBeforeCreation
        super.init(maxTimeBeforeReset: maxTimeBeforeReset)
    }
    
    public override func getApplicationNamespace() -> String {
        return String(reflecting: TimeConditions.self).split(separator: ".")[0].description
    }
    
    public override func getConditionsKey() -> String {
        return "inAppActionTimeConditions"
    }
    
    public override func getInAppActionParameterClass() -> String {
        return "TimeConditionsParameter"
    }
    
    public override func updateInAppActionConditionsParameter(_ conditionsParameter: InAppActionConditionsParameter) {
        if let strategyParameter = conditionsParameter as? TimeConditionsParameter {
            let currentTime: Double = CFAbsoluteTimeGetCurrent()
            if strategyParameter.lastDetectionTime + 3 < currentTime {
                GlobalLogger.shared.debug("delay before creating " , delayBeforeCreation)
                strategyParameter.timeToShowAlert = currentTime + delayBeforeCreation
            }
            strategyParameter.lastDetectionTime = currentTime + 0
        }
        super.updateInAppActionConditionsParameter(conditionsParameter)
    }
    
    public override func isConditionValid(_ conditionsParameter: InAppActionConditionsParameter) -> Bool {
        if let strategyParameter = conditionsParameter as? TimeConditionsParameter {
            GlobalLogger.shared.debug("delay remaining " , ( CFAbsoluteTimeGetCurrent() - strategyParameter.timeToShowAlert))
            return strategyParameter.timeToShowAlert < CFAbsoluteTimeGetCurrent()
        }
        return true
    }
}

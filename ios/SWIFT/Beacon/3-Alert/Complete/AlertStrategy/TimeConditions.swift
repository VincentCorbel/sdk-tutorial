//
//  TimeConditions.swift
//  AlertStrategy
//
//  Created by Ludovic Vimont on 13/11/2017.
//  Copyright © 2017 R&D connecthings. All rights reserved.
//

import Foundation
import ConnectPlaceActions

public class TimeConditions: InAppActionConditionsDefault {
    var delayBeforeCreation: Double!

    init(maxTimeBeforeReset: Double, delayBeforeCreation: Int) {
        super.init(maxTimeBeforeReset: maxTimeBeforeReset)
        self.delayBeforeCreation = (Double(delayBeforeCreation) / 1000.0)
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
                print("delay before creating " , delayBeforeCreation)
                strategyParameter.timeToShowAlert = currentTime + delayBeforeCreation
            }
            strategyParameter.lastDetectionTime = currentTime + 0
        }
        super.updateInAppActionConditionsParameter(conditionsParameter)
    }

    public override func isConditionValid(_ conditionsParameter: InAppActionConditionsParameter) -> Bool {
        if let strategyParameter = conditionsParameter as? TimeConditionsParameter {
            return strategyParameter.timeToShowAlert < CFAbsoluteTimeGetCurrent ()
        }
        return true
    }
}

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

public class TimeConditionsFirstWay: InAppActionConditions, InAppActionConditionsUpdater {
    let maxTimeBeforeReset: Double
    let timeProvider: TimeProvider
    let delayBeforeCreation: Double

    public init(maxTimeBeforeReset: Double = 60, delayBeforeCreation: Double = 60) {
        self.maxTimeBeforeReset = maxTimeBeforeReset
        self.delayBeforeCreation = delayBeforeCreation
        self.timeProvider = TimeProviderAbsolute()
    }
    
    public func getApplicationNamespace() -> String {
        return String(reflecting: TimeConditionsFirstWay.self).split(separator: ".")[0].description
    }
    
    public func getConditionsKey() -> String {
        return "inAppActionTimeConditions"
    }
    
    public func getInAppActionParameterClass() -> String {
        return "TimeConditionsParameter"
    }
    
    public func updateInAppActionConditionsParameter(_ conditionsParameter: InAppActionConditionsParameter) {
        updateLastDetectionTime(conditionsParameter)
        conditionsParameter.isConditionValid = isConditionValid(conditionsParameter)
        conditionsParameter.inAppActionStatus = updateInAppActionStatus(conditionsParameter)
        conditionsParameter.isReadyForAction = isReadyForAction(conditionsParameter)
        conditionsParameter.maxTimeBeforeActionDoneReset = updateMaxTimeBeforeActionDoneReset(conditionsParameter)
    }

    public func updateLastDetectionTime(_ conditionsParameter: InAppActionConditionsParameter) {
        if let strategyParameter = conditionsParameter as? TimeConditionsParameter {
            let currentTime: Double = timeProvider.getTime()
            if strategyParameter.lastDetectionTime + 3 < currentTime {
                GlobalLogger.shared.debug("delay before creating " , delayBeforeCreation)
                strategyParameter.timeToShowAlert = currentTime + delayBeforeCreation
            }
            strategyParameter.lastDetectionTime = currentTime + 0
        }
    }

    public func isConditionValid(_ conditionsParameter: InAppActionConditionsParameter) -> Bool {
        if let strategyParameter = conditionsParameter as? TimeConditionsParameter {
            GlobalLogger.shared.debug("remaining time ",(timeProvider.getTime() - strategyParameter.timeToShowAlert))
            return strategyParameter.timeToShowAlert < timeProvider.getTime()
        } else {
            return true
        }
    }

    public func isReadyForAction(_ conditionsParameter: InAppActionConditionsParameter) -> Bool {
       return conditionsParameter.inAppActionStatus == InAppActionStatus.WAITING_FOR_ACTION
            && conditionsParameter.isConditionValid
    }

    public func updateMaxTimeBeforeActionDoneReset(_ conditionsParameter: InAppActionConditionsParameter) -> Double {
        return timeProvider.getTime() + maxTimeBeforeReset
    }

    public func updateInAppActionStatus(_ conditionsParameter: InAppActionConditionsParameter) -> InAppActionStatus {
        if conditionsParameter.inAppActionStatus == InAppActionStatus.DONE {
            if !conditionsParameter.isConditionValid
                || conditionsParameter.maxTimeBeforeActionDoneReset < timeProvider.getTime() {
                return InAppActionStatus.WAITING_FOR_ACTION
            }
        }
        return conditionsParameter.inAppActionStatus
    }
}



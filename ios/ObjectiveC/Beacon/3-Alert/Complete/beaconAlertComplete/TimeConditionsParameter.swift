//
//  TimeConditionsParameter.swift
//  beaconAlertComplete
//
//  Created by Connecthings on 14/11/2017.
//  Copyright © 2017 Connecthings. All rights reserved.
//

import Foundation
import ConnectPlaceActions

@objc public class TimeConditionsParameter: InAppActionConditionsParameter {
    var lastDetectionTime: Double = 0
    var timeToShowAlert: Double = 0
}

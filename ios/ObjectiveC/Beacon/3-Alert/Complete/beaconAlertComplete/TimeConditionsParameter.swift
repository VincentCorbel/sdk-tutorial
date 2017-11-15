//
//  TimeConditionsParameter.swift
//  beaconAlertComplete
//
//  Created by Ludovic Vimont on 14/11/2017.
//  Copyright © 2017 sarra srairi. All rights reserved.
//

import Foundation
import ConnectPlaceActions

@objc public class TimeConditionsParameter: InAppActionConditionsParameter {
    var lastDetectionTime: Double = 0
    var timeToShowAlert: Double = 0
}

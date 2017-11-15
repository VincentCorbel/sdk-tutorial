//
//  TimeConditionsParameter.swift
//  AlertStrategy
//
//  Created by Ludovic Vimont on 13/11/2017.
//  Copyright © 2017 R&D connecthings. All rights reserved.
//

import Foundation
import ConnectPlaceActions

public class TimeConditionsParameter: InAppActionConditionsParameter {
    var lastDetectionTime: Double = 0
    var timeToShowAlert: Double = 0
}

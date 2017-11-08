//
//  AsyncNotificationTask.swift
//  Complete
//
//  Created by Ludovic Vimont on 27/10/2017.
//  Copyright © 2017 R&D connecthings. All rights reserved.
//

import Foundation
import PromiseKit
import ConnectPlaceActions
import AdtagConnection
import AdtagLocationBeacon

public class AsyncNotificationTask: NSObject, AdtagNotificationTaskDelegate {
    public func launchNotificationTask(placeNotification: AdtagPlaceNotification, displayPlaceNotificationDelegate: DisplayPlaceNotificationDelegate) {
        displayPlaceNotificationDelegate.displayPlaceNotification(PlaceNotificationImage(placeNotification: placeNotification))
    }
}

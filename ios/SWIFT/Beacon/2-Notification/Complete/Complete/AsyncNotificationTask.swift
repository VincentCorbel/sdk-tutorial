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

public class AsyncNotificationTask: AdtagNotificationTaskDelegate {
    public func launchNotificationTask(_ placeNotification: PlaceNotification) -> AnyPromise {
        return AnyPromise(Promise<PlaceNotificationImage> { fulfill, reject in
            let placeNotificationImage: PlaceNotificationImage? = PlaceNotificationImage(placeNotification: placeNotification)
            if let placeNotificationImage = placeNotificationImage {
                fulfill(placeNotificationImage)
            } else {
                reject("An error occured...")
            }
        })
    }
}

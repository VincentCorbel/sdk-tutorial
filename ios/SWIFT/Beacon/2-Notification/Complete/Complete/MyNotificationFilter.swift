//
//  MyNotificationFilter.swift
//  Complete
//
//  Created by Connecthings on 24/11/2017.
//  Copyright © 2017 R&D connecthings. All rights reserved.
//

import Foundation

//
//  MyNotificationFilter.swift
//  Complete
//
//  Created by Connecthings on 23/11/2017.
//  Copyright © 2017 R&D connecthings. All rights reserved.
//
import Foundation
import ConnectPlaceActions

class MyNotificationFilter: NotificationFilter {
    static let MIN_NEXT_TIME_NOTIFICATION: String = "com.notification.minNextTimeNotification"

    let minTimeBetweenNotification: Double
    var minNextTimeNotification: Double

    init(_ minTimeBetweenNotification: Double) {
        self.minTimeBetweenNotification = minTimeBetweenNotification
        self.minNextTimeNotification = 0
    }

    public func getName() -> String {
        return "MyNotificationFilter";
    }

    public func createNewNotification(placeNotification: PlaceNotification) -> Bool {
        return self.minNextTimeNotification < CACurrentMediaTime()
    }

    public func deleteCurrentNotification(placeNotification: PlaceNotification?) -> Bool {
        return true
    }

    public func onNotificationCreated(placeNotification: PlaceNotification, created: Bool) {

    }

    public func onNotificationDeleted(placeNotification: PlaceNotification?, deleted: Bool) {
        if (deleted) {
            minNextTimeNotification = CACurrentMediaTime() + minTimeBetweenNotification;
        }
    }

    public func onBackground() {

    }

    public func onForeground() {

    }

    public func load(userDefaults: UserDefaults) {
        minNextTimeNotification = userDefaults.double(forKey: MyNotificationFilter.MIN_NEXT_TIME_NOTIFICATION)
    }

    public func save(userDefaults: UserDefaults) {
        userDefaults.set(minNextTimeNotification, forKey: MyNotificationFilter.MIN_NEXT_TIME_NOTIFICATION)
    }

    public func updateParameters(parameters: AnyObject) {

    }
}


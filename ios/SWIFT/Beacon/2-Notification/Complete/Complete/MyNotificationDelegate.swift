//
//  NotificationDelegate.swift
//  QuickStart
//
//  Created by Connecthings on 09/11/2017.
//  Copyright © 2017 R&D connecthings. All rights reserved.
//

import Foundation
import UserNotifications
import AdtagLocationBeacon

public class MyNotificationDelegate: NSObject, UNUserNotificationCenterDelegate {

    let adtagBeaconManager: AdtagBeaconManager

    public init(adtagBeaconManager: AdtagBeaconManager) {
        self.adtagBeaconManager = adtagBeaconManager
        super.init()
    }

    @available(iOS 10.0, *)
    public func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {
        adtagBeaconManager.didReceivePlaceNotification(response.notification.request.content.userInfo)
    }

}

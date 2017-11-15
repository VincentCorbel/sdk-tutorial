//
//  AppDelegate.swift
//  Complete
//
//  Created by Stevens Olivier on 26/01/2017.
//  Copyright © 2017 R&D connecthings. All rights reserved.
//

import UIKit
import ConnectPlaceActions
import AdtagConnection
import AdtagLocationBeacon

@UIApplicationMain

class AppDelegate: NSObject, UIApplicationDelegate {
    private let notificationIdentifier: String = "INVITE_CATEGORY"
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        AdtagInitializer.shared.configPlatform(Platform.preProd)
                               .configUser(login: "Lvi_cbeacon", password: "RGVZChwWe3LNqwBTY7qa", company: "ccbeacondemo")
                               .synchronize()

        AdtagInitializer.shared.initGroup(category: "sdk-group-filter", fieldName: "group-filter")
        
        AdtagBeaconManager.shared.registerNotificationBuilder(MyBeaconNotificationBuilder())
        AdtagBeaconManager.shared.registerNotificationTask(AsyncNotificationTask())

        if #available(iOS 10.0, *) {
        } else{
            if UIApplication.instancesRespond(to: #selector(UIApplication.registerUserNotificationSettings(_:))) {
                let notificationCategory: UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
                notificationCategory.identifier = notificationIdentifier
                UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings (types: [.alert, .badge, .sound], categories: nil))
            }
        }

        return true
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        AdtagBeaconManager.shared.didReceivePlaceNotification(notification.userInfo)
    }
}

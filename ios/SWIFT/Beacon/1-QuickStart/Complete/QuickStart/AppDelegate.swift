//
//  AppDelegate.swift
//  QuickStart
//
//  Created by sarra srairi on 10/08/2016.
//  Copyright © 2016 R&D connecthings. All rights reserved.
//

import UIKit
import AdtagConnection
import AdtagLocationBeacon
import AVFoundation
import UserNotifications
import ConnectPlaceActions

@UIApplicationMain

class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        AdtagInitializer.shared
            .configPlatform(Platform.preProd)
            .configUser(login: "Lvi_cbeacon", password: "RGVZChwWe3LNqwBTY7qa", company: "ccbeacondemo")
            .synchronize()
        
        AdtagBeaconManager.shared.registerNotificationFilter(MyNotificationFilter(timeBetweenNotification: 5 * 60 * 1000))
        
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                // Enable or disable features based on authorization.
            }
            let setting = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(setting)
            UIApplication.shared.registerForRemoteNotifications()
        } else {
            if(UIApplication.instancesRespond(to: #selector(UIApplication.registerUserNotificationSettings(_:)))){
                let notificationCategory:UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
                notificationCategory.identifier = "INVITE_CATEGORY"
                UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings (types: [.alert, .badge, .sound], categories: nil))
            }
        }
        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        
    }
    
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        
    }
}

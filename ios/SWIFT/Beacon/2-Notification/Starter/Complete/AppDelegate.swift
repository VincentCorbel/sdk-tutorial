//
//  AppDelegate.swift
//  Complete
//
//  Created by Connecthings on 26/01/2017.
//  Copyright © 2017 R&D connecthings. All rights reserved.
//

import UIKit
import ConnectPlaceActions
import AdtagConnection
import AdtagLocationBeacon
import UserNotifications

@UIApplicationMain

class AppDelegate: NSObject, UIApplicationDelegate, AdtagReceiveNotificationContentDelegate {
    private let notificationIdentifier: String = "INVITE_CATEGORY"
    var window: UIWindow?
    var adtagInitializer: AdtagInitializer?
    var adtagBeaconManager: AdtagBeaconManager?
    var myNotificationDelegate: MyNotificationDelegate?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        adtagInitializer = AdtagInitializer.shared
        adtagInitializer?.configPlatform(Platform.preProd)
                               .configUser(login: "__LOGIN__", password: "__PASSWORD__", company: "__COMPANY__")
                               .synchronize()

        //AdtagInitializer.shared.initGroup(category: "sdk-group-filter", fieldName: "group-filter")
        adtagBeaconManager = AdtagBeaconManager.shared
        adtagBeaconManager?.registerReceiveNotificatonContentDelegate(self)
   
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            //The request can be done as well in a viewController which allows to display a message if the user refuse the receive notifications
            center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                if (error == nil) {
                    NSLog("request authorization succeeded!");
                }
            }
            myNotificationDelegate = MyNotificationDelegate(adtagBeaconManager: adtagBeaconManager!)
            center.delegate = myNotificationDelegate
        } else if(UIApplication.instancesRespond(to: #selector(UIApplication.registerUserNotificationSettings(_:)))){
            UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings (types: [.alert, .sound], categories: nil))
        }

        return true
    }
    
    func applicationWillResignActive(_ application: UIApplication) {
        adtagInitializer?.onAppInBackground()
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        adtagInitializer?.onAppInForeground()
    }

    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        adtagBeaconManager?.didReceivePlaceNotification(notification.userInfo)
    }

    func didReceivePlaceNotification(_ placeNotification: AdtagPlaceNotification) {
        NSLog("open a controller with a place notification")
        //Quick way to notify controller
        let beaconContentUserInfo:[String: PlaceNotification] = ["placeNotification": placeNotification]
        NotificationCenter.default.post(name: NSNotification.Name("placeNotification"), object:nil, userInfo: beaconContentUserInfo)
    }

    func didReceiveWelcomeNotification(_ welcomeNotification: AdtagPlaceWelcomeNotification) {
        NSLog("open a controller with a place welcome notification")
        //Quick way to notify controller
        let beaconContentUserInfo:[String: PlaceNotification] = ["placeNotification": welcomeNotification]
        NotificationCenter.default.post(name: NSNotification.Name("placeNotification"), object:nil, userInfo: beaconContentUserInfo)
    }
}

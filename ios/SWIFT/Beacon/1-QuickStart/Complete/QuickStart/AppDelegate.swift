//
//  AppDelegate.swift
//  QuickStart
//
//  Created by sarra srairi on 10/08/2016.
//  Copyright © 2016 R&D connecthings. All rights reserved.
//

import UIKit

import AVFoundation
import UserNotifications
import AdtagConnection
import AdtagLocationBeacon

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, AdtagReceiveNotificationContentDelegate {
    var window: UIWindow?
    var adtagInitializer: AdtagInitializer?
    var adtagBeaconManager: AdtagBeaconManager?
    var myNotificationDelegate: MyNotificationDelegate?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        adtagInitializer = AdtagInitializer.shared
        adtagInitializer?.configPlatform(Platform.preProd).configUser(login: "__USER__", password: "__PASSWORD__", company: "__COMPANY__").synchronize()
        adtagBeaconManager = AdtagBeaconManager.shared

        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            //The request can be done as well in a viewController which allows to display a message if the user refuse to receive notifications
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
        adtagBeaconManager?.registerReceiveNotificatonContentDelegate(self)
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
    }

    func didReceiveWelcomeNotification(_ welcomeNotification: AdtagPlaceWelcomeNotification) {
        NSLog("open a controller with a place welcome notification")
    }
}

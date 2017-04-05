//
//  AppDelegate.swift
//  NotificationStrategy
//
//  Created by sarra srairi on 11/08/2016.
//  Copyright © 2016 R&D connecthings. All rights reserved.
//

import UIKit
import ATConnectionHttp
import ATAnalytics
import ATLocationBeacon
import UserNotifications

@UIApplicationMain

class AppDelegate: ATBeaconAppDelegate, UIApplicationDelegate, ATBeaconReceiveNotificatonContentDelegate {
    var window: UIWindow?
    var beaconNotificationFilter:BeaconNotificationFilter!
    
    func application(_ application: UIApplication, willFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey : Any]? = nil) -> Bool {
        let USER = "User_cbeacon";
        let PASS = "fSKbCEvCDCbYTDlk";
        let COMPANY = "ccbeacondemo";
        let UUID = "B0462602-CBF5-4ABB-87DE-B05340DCCBC6";
        
        initAdtagInstance(with: ATUrlTypeDev, userLogin: USER, userPassword: PASS, userCompany: COMPANY, beaconUuid: UUID, activatIos10Workaround: true)
        ATAdtagInitializer.sharedInstance().synchronize()
        
        addNotificationStrategy(BeaconNotificationFilter(timeBetweenNotification: 5 * 60 * 1000))
        
        /* Required --- Ask for User Permission to Receive (UILocalNotifications/ UIUserNotification) in iOS 8 and later
         / -- Registering Notification Settings **/
        if #available(iOS 10.0, *) {
        } else {
            if(UIApplication.instancesRespond(to: #selector(UIApplication.registerUserNotificationSettings(_:)))){
                let notificationCategory:UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
                notificationCategory.identifier = "INVITE_CATEGORY"
                //registerting for the notification.
                UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings (types: [.alert, .badge, .sound], categories: nil))
            }
        }
        
        return true
    }
    
    /** Receive the local notification **/
    override func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        super.application(application, didReceive: notification)
        ATBeaconManager.sharedInstance().didReceive(notification);
    }
    
    override func applicationWillResignActive(_ application: UIApplication) {
        /* ** Required
         * Add super.applicationWillResignActive to your  delegate method
         * the super class will init the range beacon
         * if a the super call isn't reachable the Beacon range won't be start
         */
        super.applicationWillResignActive(application)
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
    }
    
    override func applicationDidBecomeActive(_ application: UIApplication) {
        /* ** Required
         * Add super.applicationDidBecomeActive to your delegate method
         * the super class will init the range beacon
         * if a the super call isn't reachable the Beacon range won't be start
         */
        super.applicationDidBecomeActive(application);
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
    }
    
    func applicationWillTerminate(application: UIApplication) {
    }
    
    func didReceiveBeaconNotification(_ _beaconContent: ATBeaconContent!){
        let dict: [NSObject : AnyObject] = ["beaconContent" as NSObject : _beaconContent]
        let nc = NotificationCenter.default
        nc.post(name:Notification.Name(rawValue:"LocalNotificationMessageReceivedNotification"),
                object: nil,
                userInfo:dict)
    }
    
    func didReceive(_ _welcomeNotificationContent: ATBeaconWelcomeNotification!) {
        
    }
}

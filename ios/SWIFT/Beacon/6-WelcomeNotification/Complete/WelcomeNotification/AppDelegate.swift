//
//  AppDelegate.swift
//  SimpleNotification
//
//  Created by sarra srairi on 10/08/2016.
//  Copyright © 2016 R&D connecthings. All rights reserved.
//


import UIKit
import ATConnectionHttp
import ATAnalytics
import ATLocationBeacon
import UserNotifications

@UIApplicationMain

class AppDelegate: ATBeaconAppDelegate, UIApplicationDelegate,ATBeaconReceiveNotificatonContentDelegate {
    
    var window: UIWindow?
    

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        /* ** Required -- used to initialize and setup the SDK
         *
         *
         *
         * If you have followed our SDK quickstart guide, you won't need to re-use this method, but you should add the parameters values.
         * -- 1- Platform : ATUrlTypePreprod  = > Pre-production Platform
         *                  ATUrlTypeProd     = > Production Platform
         *                  ATUrlTypeDemo     = > Demo Platform
         *
         * Key/Value are related to the selected Platform
         * -- 2- user Login : Login delivred by the Connecthings staff
         * -- 3- user Password : Password delivred by the Connecthings staff
         * -- 4- user Compagny : Define the compagny name
         * -- 5- beaconUuid : - UUID beacon number delivred by the Connecthings staff
         * --
         *
         * All other SDK methods must be called after this one, because they won't exist until you do.
         */
        let uuids = ["__UID__"]
        initAdtagInstance(with: ATUrlTypeDev, userLogin: "__LOGIN__", userPassword: "__PSWD__", userCompany: "__COMPANY__", beaconArrayUuids: uuids, activatIos10Workaround: true)
        
        self.add(ATBeaconWelcomeNotification.init(title:"Nice Welcome Notification", description: "Good news: You have got network", picture: "wn_network_on.jpg", minDisplayTime: 1000 * 60 * 2, welcomeNotificationType: ATBeaconWelcomeNotificationTypeNetworkOn))
        
        
        self.add(ATBeaconWelcomeNotification.init(title:"Nice Welcome Notification", description: "No network? Lucky you are, a free wifi is available!",picture:"wn_network_off.jpg", minDisplayTime: 1000 * 60 * 2, welcomeNotificationType: ATBeaconWelcomeNotificationTypeNetworkOff))
        
        self.register(ATAsyncBeaconWelcomeNotificationImageCreator.init(welcomeNotificationImageBuilder: MyBeaconWelcomeNotificationBuilder()))
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
            ATBeaconManager.sharedInstance().registerNotificationContentDelegate(self);
        return true
    }
    
    
    override func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        super.application(application, didReceive: notification)
        ATBeaconManager.sharedInstance().didReceive(notification);
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
    
    func didReceiveBeaconNotification(_ _beaconContent: ATBeaconContent!) {
        let dict: [NSObject : AnyObject] = ["beaconContent" as NSObject : _beaconContent]
        let nc = NotificationCenter.default
        nc.post(name:Notification.Name(rawValue:"LocalNotificationMessageReceivedNotification"),
                object: nil,
                userInfo:dict)
        
    }
    
    func didReceive(_ _welcomeNotificationContent: ATBeaconWelcomeNotification!) {
        let dict: [NSObject : AnyObject] = ["welcomeNotification" as NSObject : _welcomeNotificationContent]
        let nc = NotificationCenter.default
        nc.post(name:Notification.Name(rawValue:"LocalNotificationMessageReceivedWelcomeNotification"),
                object: nil,
                userInfo:dict)
    }

    
    
}


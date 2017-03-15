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
        let uuids = ["__UUID__"]
        initAdtagInstance(with: ATUrlTypeProd, userLogin: "__LOGIN__", userPassword: "__PSWD__", userCompany: "__COMPANY__", beaconArrayUuids: uuids, activatIos10Workaround: true)
        /**
         * The notifications strategies....
        **/
        // the current beacon notification is not replaced by a notification associated to the new beacon.
        //addNotificationStrategy(ATBeaconNotificationStrategySpamRegionFilter(categoryAndField: "beacon-notification", field: "title"))
        
        //Limit the number of notifications in a lapse time : in our case the application won't create more than 2 beacon notifications each hours
        //addNotificationStrategy(ATBeaconNotificationStrategySpamMaxFilter(notificationMaxNumber: 2, timeBtwNotification: 60 * 1000 * 60))
        
        //Permit to define :
        // - a time to wait before displaying a first notification after the application goes to background (in our exemple 10 minutes)
        // - a time to wait before displaying a new beacon notification (in our exemples 20 minutes
        //addNotificationStrategy(ATBeaconNotificationStrategySpamTimeFilter(minTimeBeforeCreatingNotificationWhenAppEnterInBackground: 60 * 1000, minTimeBetweenTwoNotification: 60 * 1000 * 20))
        
       
        
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
    
    /** Receive the local notification **/
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
    
    func didReceiveBeaconNotification(_ _beaconContent: ATBeaconContent!){
        let dict: [NSObject : AnyObject] = ["beaconContent" as NSObject : _beaconContent]
        let nc = NotificationCenter.default
        nc.post(name:Notification.Name(rawValue:"LocalNotificationMessageReceivedNotification"),
                object: nil,
                userInfo:dict)
        
    }
    
    func didReceive(_ _welcomeNotificationContent: ATBeaconWelcomeNotification!){
        
    }
}

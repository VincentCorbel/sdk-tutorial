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
class AppDelegate: ATBeaconAppDelegate, UIApplicationDelegate,ATBeaconReceiveNotificatonContentDelegate {
    
    var window: UIWindow?
    var beaconNotificationFilter:BeaconNotificationFilter!
    
    
    
    
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
        ATAdtagInitializer.sharedInstance().configureUrlType(__UrlType__, andLogin: "__USER__", andPassword: "__PSWD__", andCompany: "__COMPANY__").synchronize()
        
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


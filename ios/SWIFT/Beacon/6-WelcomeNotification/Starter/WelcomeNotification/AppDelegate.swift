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


@UIApplicationMain
class AppDelegate: ATBeaconAppDelegate, UIApplicationDelegate,ATBeaconNotificationDelegate, ATBeaconWelcomeNotificationDelegate {
    
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
         initAdtagInstance(with:ATUrlTypePreprod ,userLogin: "*****LOGIN****" ,userPassword: "****PASSWORD****" ,userCompany: "****COMPAGNY****" ,beaconUuid: "****UUID****")
 
        
        
        if  ((launchOptions?[UIApplicationLaunchOptionsKey.location] as? NSDictionary) != nil) {
        }
        
        if(UIApplication.instancesRespond(to: #selector(UIApplication.registerUserNotificationSettings(_:)))){
            let notificationCategory:UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
            notificationCategory.identifier = "INVITE_CATEGORY"
            //registerting for the notification.
            application.registerUserNotificationSettings(UIUserNotificationSettings(types:[ .sound, .alert,
                                                                                               .badge], categories: nil));
        }
        return true
    }
    
    func application(_ application: UIApplication, didReceive notification: UILocalNotification) {
        
        if application.applicationState != UIApplicationState.active {
            
            let fromDefaultNotification: Bool = notification.userInfo != nil && CBool((notification.userInfo!["isWelcomeNotification"] as! Bool))
            if fromDefaultNotification {
                
                let dict: [AnyHashable: Any] = [ "Congratulations! You generate your first beacon welcome notification" : "test" ]
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "LocalNotificationMessageReceivedNotification"), object: nil, userInfo: dict)
            }else {
                let beaconContent: ATBeaconContent = ATBeaconManager.sharedInstance().getNotificationBeaconContent()
                let dict: [AnyHashable: Any] = [
                    "beaconContent" : beaconContent]
                
                NotificationCenter.default.post(name: Notification.Name(rawValue: "LocalNotificationMessageReceivedNotification"), object: nil, userInfo: dict)
            }
        }
    }
    
    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    override func applicationDidBecomeActive(_ application: UIApplication) {
        super.applicationDidBecomeActive(application)
    }
    
    override func applicationWillResignActive (_ application: UIApplication){
        super.applicationWillResignActive(application)
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func createWelcomeNotification(_ beaconWelcomeNotification: ATBeaconWelcomeNotification) -> UILocalNotification {
        
 
    }
    
    func createNotification(_ _beaconContent: ATBeaconContent!) -> UILocalNotification! {
        
        let kLocalNotificationMessage:String! = _beaconContent.getNotificationDescription()
        let kLocalNotificationAction:String! = _beaconContent.getAlertTitle()
        let localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertBody = kLocalNotificationMessage
        localNotification.alertAction = kLocalNotificationAction
        print("create notification from app delegate");
        localNotification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.shared.scheduleLocalNotification(localNotification)
        
        return localNotification;
    }
    
}


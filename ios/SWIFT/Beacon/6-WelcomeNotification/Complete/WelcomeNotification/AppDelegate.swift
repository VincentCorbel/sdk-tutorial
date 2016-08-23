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
class AppDelegate: ATBeaconAppDelegate, UIApplicationDelegate,ATBeaconNotificationDelegate {
    
    var window: UIWindow?
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        // HELP:
        // init the adtag platforme with the
        // ** user Login : Login delivred by the Connecthings staff
        // ** user Password : Password delivred by the Connecthings staff
        // ** user Compagny : ....
        // ** beaconUuid : - UUID beacon number devivred by the Connecthings staff
        
        initAdtagInstanceWithUrlType(ATUrlTypeItg ,userLogin: "*****" ,userPassword: "*****" ,userCompany: "*****" ,beaconUuid: "*****");
        
        
        self.addWelcomeNotification(ATBeaconWelcomeNotification.init(title:"Nice Welcome Notification", description: "Good news: You have got network", minDisplayTime: 1000 * 60 * 2, welcomeNotificationType: ATBeaconWelcomeNotificationTypeNetworkOn))
        
 
        self.addWelcomeNotification(ATBeaconWelcomeNotification.init(title:"Nice Welcome Notification", description: "No network? Lucky you are, a free wifi is available!", minDisplayTime: 1000 * 60 * 2, welcomeNotificationType: ATBeaconWelcomeNotificationTypeNetworkOff))
        
        
        
        
        if  ((launchOptions?[UIApplicationLaunchOptionsLocationKey] as? NSDictionary) != nil) {
        }
        
        if(UIApplication.instancesRespondToSelector(#selector(UIApplication.registerUserNotificationSettings(_:)))){
            let notificationCategory:UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
            notificationCategory.identifier = "INVITE_CATEGORY"
            //registerting for the notification.
            application.registerUserNotificationSettings(UIUserNotificationSettings(forTypes:[ .Sound, .Alert,
                .Badge], categories: nil));
        }
        return true
    }
    
    func application(application: UIApplication, didReceiveLocalNotification notification: UILocalNotification) {
        
        if application.applicationState != UIApplicationState.Active {
            
            let fromDefaultNotification: Bool = notification.userInfo != nil && CBool((notification.userInfo!["isWelcomeNotification"] as! Bool))
            if fromDefaultNotification {
     
                let dict: [NSObject : AnyObject] = [
                   "Congratulations! You generate your first beacon welcome notification" : "test"
                ]
                
                NSNotificationCenter.defaultCenter().postNotificationName("LocalNotificationMessageReceivedNotification", object: nil, userInfo: dict)
            }else {
            let beaconContent: ATBeaconContent = ATBeaconManager.sharedInstance().getNotificationBeaconContent()
            let dict: [NSObject : AnyObject] = [
                "beaconContent" : beaconContent]
            
            NSNotificationCenter.defaultCenter().postNotificationName("LocalNotificationMessageReceivedNotification", object: nil, userInfo: dict)
            }
        }
    }
    
    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }
    
    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }
    
    override func applicationDidBecomeActive(application: UIApplication) {
        super.applicationDidBecomeActive(application)
    }
    
    override func applicationWillResignActive (application: UIApplication){
        super.applicationWillResignActive(application)
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    func createNotification(_beaconContent: ATBeaconContent!) -> UILocalNotification! {
        
        let kLocalNotificationMessage:String! = _beaconContent.getNotificationDescription()
        let kLocalNotificationAction:String! = _beaconContent.getAlertTitle()
        let localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertBody = kLocalNotificationMessage
        localNotification.alertAction = kLocalNotificationAction
        print("create notification from app delegate");
        localNotification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.sharedApplication().scheduleLocalNotification(localNotification)
        
        return localNotification;
    }
    
}


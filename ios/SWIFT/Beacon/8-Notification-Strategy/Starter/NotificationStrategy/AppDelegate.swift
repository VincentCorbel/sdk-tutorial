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


@UIApplicationMain
class AppDelegate: ATBeaconAppDelegate, UIApplicationDelegate,ATBeaconNotificationDelegate {
    
    var window: UIWindow?
    var beaconNotificationFilter:BeaconNotificationFilter!
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        // HELP:
        // init the adtag platforme with the
        // ** user Login : Login delivred by the Connecthings staff
        // ** user Password : Password delivred by the Connecthings staff
        // ** user Compagny : ....
        // ** beaconUuid : - UUID beacon number devivred by the Connecthings staff
        
        initAdtagInstanceWithUrlType(ATUrlTypeItg ,userLogin: "*****" ,userPassword: "*****" ,userCompany: "*****" ,beaconUuid: "*****");
        
     
        
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
        let localNotification:UILocalNotification = UILocalNotification()
        return localNotification;
    }
    
}


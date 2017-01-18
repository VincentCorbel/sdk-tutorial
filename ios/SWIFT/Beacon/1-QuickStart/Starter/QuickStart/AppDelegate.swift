//
//  AppDelegate.swift
//  QuickStart
//
//  Created by sarra srairi on 10/08/2016.
//  Copyright © 2016 R&D connecthings. All rights reserved.
//

import UIKit
import ATAnalytics
import ATLocationBeacon
import AVFoundation

/******** MUST KNOW !!!!
 IF YOU WILL IMPLEMENT THE applicationDidBecomeActive METHOD YOU SHOULD ADD [super applicationDidBecomeActive:application];
 -   the super method will activate the range in your project
 */
@UIApplicationMain
class AppDelegate: ATBeaconAppDelegate, UIApplicationDelegate {
    
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
    
    
    override func applicationDidBecomeActive(_ application: UIApplication) {
        
        /* ** Required
         * Add super.applicationDidBecomeActive to your delegate method
         * the super class will init the range beacon
         * if a the super call isn't reachable the Beacon range won't be start
         */
        super.applicationDidBecomeActive(application);
    }
    
  
    
    
}


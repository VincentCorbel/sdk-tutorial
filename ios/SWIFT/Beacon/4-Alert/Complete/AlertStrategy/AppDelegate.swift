//
//  AppDelegate.swift
//  AlertStrategy
//
//  Created by sarra srairi on 11/08/2016.
//  Copyright © 2016 R&D connecthings. All rights reserved.
//

import UIKit
import ATAnalytics
import ATLocationBeacon
import AVFoundation

@UIApplicationMain
class AppDelegate: ATBeaconAppDelegate, UIApplicationDelegate {
    
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
        
        return true
    }
    
    override func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
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
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }
    
    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }
    
    
}


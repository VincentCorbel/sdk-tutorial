//
//  AppDelegate.swift
//  Authorization
//
//  Created by sarra srairi on 10/08/2016.
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


}


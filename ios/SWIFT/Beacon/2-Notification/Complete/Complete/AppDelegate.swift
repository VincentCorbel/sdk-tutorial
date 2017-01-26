//
//  AppDelegate.swift
//  Complete
//
//  Created by Stevens Olivier on 26/01/2017.
//  Copyright © 2017 R&D connecthings. All rights reserved.
//

import UIKit
import ATLocationBeacon

@UIApplicationMain
class AppDelegate: ATBeaconAppDelegate, UIApplicationDelegate, ATBeaconReceiveNotificatonContentDelegate {

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
        initAdtagInstance(with: ATUrlTypeDev, userLogin: "__LOGIN__", userPassword: "__PASSWORD__", userCompany: "__COMPANY__", beaconArrayUuids: uuids, activatIos10Workaround: true)
        
        register(ATAsyncBeaconNotificationImageCreator.init(createBeaconNotification:MyBeaconNotificationBuilder.init()))
        
        if #available(iOS 10.0, *) {
        }else{
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
    }
    
    public func didReceiveBeaconNotification(_ _beaconContent: ATBeaconContent!){
        let beaconContentUserInfo:[String: ATBeaconContent] = ["beaconContent": _beaconContent]
        
        NotificationCenter.default.post(name: NSNotification.Name("beaconNotification"), object:nil, userInfo: beaconContentUserInfo)
    }
    
    public func didReceiveWelcomeBeaconNotification(_ _welcomeNotificationContent: ATBeaconWelcomeNotification!){
        
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


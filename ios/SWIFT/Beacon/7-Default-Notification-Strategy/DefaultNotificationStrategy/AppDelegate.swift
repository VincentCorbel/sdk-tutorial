//
//  AppDelegate.swift
//  DefaultNotificationStrategy
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
    
    
    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        
        // Override point for customization after application launch.
        // HELP:
        // init the adtag platforme with the
        // ** user Login : Login delivred by the Connecthings staff
        // ** user Password : Password delivred by the Connecthings staff
        // ** user Compagny : ....
        // ** beaconUuid : - UUID beacon number devivred by the Connecthings staff
        
        initAdtagInstanceWithUrlType(ATUrlTypeItg ,userLogin: "*****" ,userPassword: "*****" ,userCompany: "*****" ,beaconUuid: "*****");
        
        /*/******** SPAM REGION FILTER ********/
         The notification sparm region is developped to associate one or many beacon to a region !  a region is a notification content and the structure  is {category, field} value.
         In this case, if the current beacon notification and the new beacon notification has the same beacon notification  title --> category :beacon-notification / field : title ) means this two beacon are in the same region
         
         Finally we will have just one notification ! means that the notification of the new beacon detected will not replace the last one cause : this two beacon are in the same region (which is the same title )
         
         syntax :
         self.addNotificationStrategy(ATBeaconNotificationStrategySpamRegionFilter(categoryAndField: "beacon-notification", field: "title"))
         */
        
        
        /*/******** SPAM Max FILTER ********/
         Limit the number of notifications in a lapse time : in our case the application won't create more than 2 beacon notifications each hours
         
         syntax :
         self.addNotificationStrategy(ATBeaconNotificationStrategySpamMaxFilter(notificationMaxNumber: 2, timeBtwNotification: 60 * 1000 * 60))
         */
        
        
        /*/******** SPAM Max FILTER ********/
         
         Permit to define :
         - a time to wait before displaying a first notification after the application goes to background (in our exemple 10 minutes)
         - a time to wait before displaying a new beacon notification (in our exemples 20 minutes
         
         
         syntax :
         self.addNotificationStrategy(ATBeaconNotificationStrategySpamTimeFilter(minTimeBeforeCreatingNotificationWhenAppEnterInBackground: 60 * 1000, minTimeBetweenTwoNotification: 60 * 1000 * 20))
         
         */
        
        
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
            let beaconContent: ATBeaconContent = ATBeaconManager.sharedInstance().getNotificationBeaconContent()
            let dict: [NSObject : AnyObject] = [
                "beaconContent" : beaconContent]
            
            NSNotificationCenter.defaultCenter().postNotificationName("LocalNotificationMessageReceivedNotification", object: nil, userInfo: dict)
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


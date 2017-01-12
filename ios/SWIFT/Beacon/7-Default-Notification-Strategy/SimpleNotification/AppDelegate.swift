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
class AppDelegate: ATBeaconAppDelegate, UIApplicationDelegate,ATBeaconNotificationDelegate {
    
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
        let uuids = ["****UUID****"]
        initAdtagInstance(with: ATUrlTypeProd, userLogin: "*****LOGIN*****", userPassword: "****PASSWORD****", userCompany: "****COMPAGNY****", beaconArrayUuids: uuids, activatIos10Workaround: false)
        
        /* Required --- Ask for User Permission to Receive (UILocalNotifications/ UIUserNotification) in iOS 8 and later
         / -- Registering Notification Settings **/
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                // Enable or disable features based on authorization.
            }
            let setting = UIUserNotificationSettings(types: [.alert, .badge, .sound], categories: nil)
            UIApplication.shared.registerUserNotificationSettings(setting)
            UIApplication.shared.registerForRemoteNotifications()
        } else {
            if(UIApplication.instancesRespond(to: #selector(UIApplication.registerUserNotificationSettings(_:)))){
                let notificationCategory:UIMutableUserNotificationCategory = UIMutableUserNotificationCategory()
                notificationCategory.identifier = "INVITE_CATEGORY"
                //registerting for the notification.
                UIApplication.shared.registerUserNotificationSettings(UIUserNotificationSettings (types: [.alert, .badge, .sound], categories: nil))
            }
        }
        
        
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
    
    func createNotification(_ _beaconContent: ATBeaconContent!) -> UILocalNotification! {
        
        let kLocalNotificationMessage:String! = _beaconContent.getNotificationDescription()
        let kLocalNotificationAction:String! = _beaconContent.getAlertTitle()
        let localNotification:UILocalNotification = UILocalNotification()
        localNotification.alertBody = kLocalNotificationMessage
        localNotification.alertAction = kLocalNotificationAction
 
        let infoDict = [ KEY_NOTIFICATION_CONTENT : _beaconContent.toJSONString() ]
        localNotification.userInfo = infoDict
        print("create notification from app delegate");
        localNotification.soundName = UILocalNotificationDefaultSoundName
        UIApplication.shared.presentLocalNotificationNow(localNotification)
        
        return localNotification;
    }
    
 
}

//
//  MyAsyncWelcomeNotificationCreator.swift
//  WelcomeNotification
//
//  Created by Connecthings on 31/01/2017.
//  Copyright © 2017 R&D connecthings. All rights reserved.
//

import Foundation
import ATLocationBeacon

class MyAsyncWelcomeNotificationCreator: NSObject, ATAsyncBeaconWelcomeNotificationDelegate{
    
    func createBeaconWelcomeNotification(_ _beaconWelcomeNotification: ATBeaconWelcomeNotification!, with notificationManager: ATAsyncBeaconWelcomeNotificationManager!) {
        //Very simple synchronous exemple
        notificationManager.displayBeaconWelcomeNotification(on: _beaconWelcomeNotification, usingNotification: createNotification(_beaconWelcomeNotification))
    }
    
    func createNotification(_ content: ATBeaconWelcomeNotification!) -> NSObject{
        let infoDict = [ content.mKey() : (content as! ATJSONModel).toJSONString() ]
        if #available(iOS 10.0, *) {
            let notificationContent:UNMutableNotificationContent! = UNMutableNotificationContent()
            notificationContent.title = content.mTitle()
            notificationContent.body = content.mDescription()
            
            notificationContent.userInfo = infoDict
            return notificationContent;
        }else{
            let localNotification:UILocalNotification = UILocalNotification()
            
            localNotification.alertTitle = content.mTitle()
            localNotification.alertBody = content.mDescription()
            
            localNotification.userInfo = infoDict
            return localNotification;
        }

    }
    
    func stopBackgroundTask() {
        
    }
}

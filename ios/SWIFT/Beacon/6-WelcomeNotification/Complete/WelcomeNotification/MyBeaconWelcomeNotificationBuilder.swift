//
//  MyBeaconWelcomeNotificationBuilder.swift
//  WelcomeNotification
//
//  Created by Connecthings on 31/01/2017.
//  Copyright © 2017 R&D connecthings. All rights reserved.
//

import Foundation
import ATLocationBeacon

class MyBeaconWelcomeNotificationBuilder: NSObject, ATBeaconWelcomeNotificationImageBuilder{
    
    
    func createBeaconWelcomeNotification(_ content: ATBeaconWelcomeNotification!, andImageUrl imageUrl: URL!) -> NSObject!{
        let infoDict = [ KEY_NOTIFICATION_CONTENT : content.toJSONString() ]
        if #available(iOS 10.0, *) {
            let notificationContent:UNMutableNotificationContent! = UNMutableNotificationContent()
            notificationContent.title = content.title
            notificationContent.body = content.description
            
            if imageUrl != nil {
                do{
                    let attachement:UNNotificationAttachment! = try UNNotificationAttachment.init(identifier: "com.connecthings.beacon.welcomeNotification.image", url: imageUrl, options: nil)
                    notificationContent.attachments = [attachement]
                }catch _{}
            }
            notificationContent.userInfo = infoDict
            return notificationContent;
        }else{
            let localNotification:UILocalNotification = UILocalNotification()
            
            localNotification.alertTitle = content.title
            localNotification.alertBody = content.description
            
            localNotification.userInfo = infoDict
            return localNotification;
        }

    }
    
}

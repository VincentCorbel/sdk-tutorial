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
        let model : ATJSONModel = (content as! ATJSONModel)
        let infoDict = [ content.mKey() : model.toJSONString() ]
        if #available(iOS 10.0, *) {
            let notificationContent:UNMutableNotificationContent! = UNMutableNotificationContent()
            notificationContent.title = content.mTitle()
            notificationContent.body = content.mDescription()
            
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
            
            localNotification.alertTitle = content.mTitle()
            localNotification.alertBody = content.mDescription()
            
            localNotification.userInfo = infoDict
            return localNotification;
        }

    }
    
}

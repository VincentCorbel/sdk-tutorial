//
//  MyBeaconNotificationBuilder.swift
//  SimpleNotification
//
//  Created by Connecthings on 26/01/2017.
//  Copyright © 2017 R&D connecthings. All rights reserved.
//

import Foundation
import ATLocationBeacon

class MyBeaconNotificationBuilder : NSObject, ATBeaconNotificationImageBuilderDelegate {
    

    func createBeaconNotification(_ content: ATBeaconContent!, andImageUrl imageUrl: URL!) -> NSObject! {
        let infoDict = [ KEY_NOTIFICATION_CONTENT : content.toJSONString() ]
        if #available(iOS 10.0, *) {
            let notificationContent:UNMutableNotificationContent! = UNMutableNotificationContent()
            notificationContent.title = content.getNotificationTitle()
            if content.isNotificationDescriptionEmpty() {
                notificationContent.body = content.getNotificationTitle()
            }else{
                notificationContent.body = content.getNotificationDescription()
            }
            
            if imageUrl != nil {
                do{
                    let attachement:UNNotificationAttachment! = try UNNotificationAttachment.init(identifier: "com.connecthings.beacon.image", url: imageUrl, options: nil)
                     notificationContent.attachments = [attachement]
                }catch _{}
            }
            notificationContent.userInfo = infoDict
            return notificationContent;
        }else{
            let kLocalNotificationMessage:String! = content.getNotificationDescription()
            let kLocalNotificationTitle:String! = content.getNotificationTitle()
            let localNotification:UILocalNotification = UILocalNotification()
            
            localNotification.alertTitle = kLocalNotificationTitle
            if kLocalNotificationMessage?.isEmpty == false {
                localNotification.alertBody = kLocalNotificationTitle
            } else {
                localNotification.alertBody = kLocalNotificationMessage
            }
            
            
            localNotification.userInfo = infoDict
            return localNotification;
        }
    }
    
}


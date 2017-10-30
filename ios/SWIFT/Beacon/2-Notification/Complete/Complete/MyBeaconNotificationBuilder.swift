//
//  MyBeaconNotificationBuilder.swift
//  SimpleNotification
//
//  Created by Connecthings on 26/01/2017.
//  Copyright © 2017 R&D connecthings. All rights reserved.
//

import Foundation
import UserNotifications
import ConnectPlaceActions
import AdtagLocationBeacon

class MyBeaconNotificationBuilder: NSObject, NotificationBuilder {
    func generateNotificationForIOS10AndPlus(placeNotificationImage: PlaceNotificationImage) -> UNMutableNotificationContent {
        let placeNotification = placeNotificationImage.getPlaceNotification()
        let notificationContent: UNMutableNotificationContent = UNMutableNotificationContent()

        notificationContent.title = placeNotification.getTitle()
        if placeNotification.getDescription().isEmpty {
            notificationContent.body = placeNotification.getTitle()
        } else {
            notificationContent.body = placeNotification.getDescription()
        }

        if placeNotificationImage.hasImage() {
            do {
                let notificationId = "com.connecthings.beacon.image"
                if let imageURL = placeNotificationImage.getImageURL() {
                    let attachement: UNNotificationAttachment! = try UNNotificationAttachment.init(identifier: notificationId, url: imageURL, options: nil)
                    notificationContent.attachments = [attachement]
                }
            } catch _{}
        }
        return notificationContent
    }

    func generateNotificationForIOS9AndMinus(placeNotificationImage: PlaceNotificationImage) -> UILocalNotification {
        let placeNotification = placeNotificationImage.getPlaceNotification()
        let localNotification: UILocalNotification = UILocalNotification()
        
        let kLocalNotificationTitle:String! = placeNotification.getTitle()
        let kLocalNotificationMessage:String! = placeNotification.getDescription()
        
        localNotification.alertTitle = kLocalNotificationTitle
        if kLocalNotificationMessage?.isEmpty == false {
            localNotification.alertBody = kLocalNotificationTitle
        } else {
            localNotification.alertBody = kLocalNotificationMessage
        }

        return localNotification
    }
}

//
//  MyBeaconWelcomeNotificationBuilder.m
//  WelcomeNotification
//
//  Created by Connecthings on 31/01/2017.
//  Copyright © 2017 com.connecthings. All rights reserved.
//

#import "MyBeaconWelcomeNotificationBuilder.h"

@implementation MyBeaconWelcomeNotificationBuilder

-(NSObject *)createBeaconWelcomeNotification:(ATBeaconWelcomeNotification *)content andImageUrl:(NSURL *)imageUrl{
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:[content toJSONString] forKey:KEY_NOTIFICATION_CONTENT];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")) {
        UNMutableNotificationContent *notificationContent = [[UNMutableNotificationContent alloc] init];
        notificationContent.title = @"title tiel";//content.title;
        notificationContent.body = content.description;
        notificationContent.userInfo = infoDict;
        if(imageUrl){
            UNNotificationAttachment *attachement1 = [UNNotificationAttachment attachmentWithIdentifier:@"com.connecthings.beaconWelcomeNotificationImage" URL:imageUrl options:nil error:nil];
            notificationContent.attachments=@[attachement1];
        }
        return notificationContent;
    }else{
        UILocalNotification *notification = [[UILocalNotification alloc]init];
        [notification setAlertBody:content.description];
        if(SYSTEM_VERSION_GREATER_THAN(@"7.99")){
            [notification setAlertTitle:content.title];
        }
        [notification setUserInfo:infoDict];
        return notification;
    }
}

@end

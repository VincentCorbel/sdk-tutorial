//
//  MyBeaconNotificationBuilder.m
//  NotificationComplete
//
//  Created by Stevens Olivier on 24/01/2017.
//  Copyright © 2017 sarra srairi. All rights reserved.
//

#import "MyBeaconNotificationBuilder.h"

@implementation MyBeaconNotificationBuilder

-(NSObject *) createBeaconNotification:(ATBeaconContent *) content andImageUrl:(NSURL *)imageUrl{
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:[content toJSONString] forKey:KEY_NOTIFICATION_CONTENT];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")) {
        UNMutableNotificationContent *notificationContent = [[UNMutableNotificationContent alloc] init];
        if([content isNotificationDescriptionEmpty]){
            notificationContent.body = [content getNotificationTitle];
        }else{
            notificationContent.body = [content getNotificationDescription];
        }
        if(![content isNotificationTitleEmpty]){
            notificationContent.title = [content getNotificationTitle];
        }
        notificationContent.userInfo = infoDict;
        if(imageUrl){
            UNNotificationAttachment *attachement1 = [UNNotificationAttachment attachmentWithIdentifier:@"com.connecthings.beaconNotificationImage" URL:imageUrl options:nil error:nil];
            notificationContent.attachments=@[attachement1];
        }
        return notificationContent;
    }else{
        ILog(@"create notification from app delegate");
        UILocalNotification *notification = [[UILocalNotification alloc]init];
        if([content isNotificationDescriptionEmpty]){
            [notification setAlertBody:[content getNotificationTitle]];
        }else{
            [notification setAlertBody:[content getNotificationDescription]];
        }
        
        if(SYSTEM_VERSION_GREATER_THAN(@"7.99") && ![content isNotificationTitleEmpty]){
            [notification setAlertTitle:[content getNotificationTitle]];
        }
        
        [notification setUserInfo:infoDict];
        return notification;
    }
}

@end

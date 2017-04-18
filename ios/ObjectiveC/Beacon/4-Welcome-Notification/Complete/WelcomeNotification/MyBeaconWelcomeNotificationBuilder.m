//
//  MyBeaconWelcomeNotificationBuilder.m
//  WelcomeNotification
//
//  Created by Connecthings on 31/01/2017.
//  Copyright © 2017 com.connecthings. All rights reserved.
//

#import "MyBeaconWelcomeNotificationBuilder.h"

@implementation MyBeaconWelcomeNotificationBuilder

-(NSObject *)createBeaconWelcomeNotification:(id<ATBeaconWelcomeNotification>)content andImageUrl:(NSURL *)imageUrl{
    ATJSONModel *model = (ATJSONModel *) content;
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:[model toJSONString] forKey:KEY_REMOTE_WELCOME_NOTIFICATION_CONTENT];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")) {
        UNMutableNotificationContent *notificationContent = [[UNMutableNotificationContent alloc] init];
        notificationContent.title = [content mTitle];
        notificationContent.body = [content mDescription];
        notificationContent.userInfo = infoDict;
        if(imageUrl){
            UNNotificationAttachment *attachement1 = [UNNotificationAttachment attachmentWithIdentifier:@"com.connecthings.beaconWelcomeNotificationImage" URL:imageUrl options:nil error:nil];
            notificationContent.attachments=@[attachement1];
        }
        return notificationContent;
    }else{
        UILocalNotification *notification = [[UILocalNotification alloc]init];
        [notification setAlertBody:[content mDescription]];
        if(SYSTEM_VERSION_GREATER_THAN(@"7.99")){
            [notification setAlertTitle:[content mTitle]];
        }
        [notification setUserInfo:infoDict];
        return notification;
    }
}

@end

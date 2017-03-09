//
//  MyAsyncBeaconWelcomeNotificationCreator.m
//  WelcomeNotification
//
//  Created by Connecthings on 31/01/2017.
//  Copyright © 2017 com.connecthings. All rights reserved.
//

#import "MyAsyncBeaconWelcomeNotificationCreator.h"

@implementation MyAsyncBeaconWelcomeNotificationCreator

-(void) createBeaconWelcomeNotification:(ATBeaconWelcomeNotification *)_beaconWelcomeNotification withNotificationManager:(id<ATAsyncBeaconWelcomeNotificationManager>)notificationManager{
    //Very simple exemple totally syncrhone ;)
    [notificationManager displayBeaconWelcomeNotificationOn:_beaconWelcomeNotification usingNotification:[self createNotification:_beaconWelcomeNotification]];
}

-(NSObject *) createNotification:(ATBeaconWelcomeNotification *) content{
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:[content toJSONString] forKey:KEY_NOTIFICATION_CONTENT];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")) {
        UNMutableNotificationContent *notificationContent = [[UNMutableNotificationContent alloc] init];
        notificationContent.title = content.title;
        notificationContent.body = content.description;
        notificationContent.userInfo = infoDict;
        
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

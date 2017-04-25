//
//  MyAsyncBeaconWelcomeNotificationCreator.m
//  WelcomeNotification
//
//  Created by Connecthings on 31/01/2017.
//  Copyright © 2017 com.connecthings. All rights reserved.
//

#import "MyAsyncBeaconWelcomeNotificationCreator.h"

@implementation MyAsyncBeaconWelcomeNotificationCreator

-(void) createBeaconWelcomeNotification:(id<ATBeaconWelcomeNotification>)_beaconWelcomeNotification withNotificationManager:(id<ATAsyncBeaconWelcomeNotificationManager>)notificationManager{
    //Very simple exemple totally syncrhone ;)
    [notificationManager displayBeaconWelcomeNotificationOn:_beaconWelcomeNotification usingNotification:[self createNotification:_beaconWelcomeNotification]];
}

-(NSObject *) createNotification:(id<ATBeaconWelcomeNotification>) content{
    ATJSONModel *model = (ATJSONModel *) content;
    NSDictionary *infoDict = [NSDictionary dictionaryWithObject:[model toJSONString] forKey:[content mKey]];
    
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")) {
        UNMutableNotificationContent *notificationContent = [[UNMutableNotificationContent alloc] init];
        notificationContent.title = [content mTitle];
        notificationContent.body = [content mDescription];
        notificationContent.userInfo = infoDict;
        
        return notificationContent;
    }else{
        UILocalNotification *notification = [[UILocalNotification alloc]init];
        [notification setAlertBody:content.description];
        if(SYSTEM_VERSION_GREATER_THAN(@"7.99")){
            [notification setAlertTitle:[content mTitle]];
        }
        [notification setUserInfo:infoDict];
        return notification;
    }

}

-(void) stopBackgroundTask{

}

@end

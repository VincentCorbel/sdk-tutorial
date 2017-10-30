//
//  MyBeaconNotificationBuilder.m
//  NotificationComplete
//
//  Created by Stevens Olivier on 24/01/2017.
//  Copyright © 2017 sarra srairi. All rights reserved.
//

#import "MyBeaconNotificationBuilder.h"

#define SYSTEM_VERSION_GREATER_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)

@implementation MyBeaconNotificationBuilder

- (UNMutableNotificationContent * _Nonnull)generateNotificationForIOS10AndPlusWithPlaceNotificationImage:(PlaceNotificationImage * _Nonnull) placeNotificationImage {
    UNMutableNotificationContent *notificationContent = [[UNMutableNotificationContent alloc] init];

    AdtagPlaceNotification *placeNotification = [placeNotificationImage getPlaceNotification];

    if([placeNotification getDescription].length <= 0) {
        notificationContent.body = [placeNotification getTitle];
    }else{
        notificationContent.body = [placeNotification getDescription];
    }
    if([placeNotification getTitle].length > 0) {
        notificationContent.title = [placeNotification getTitle];
    }

    if (placeNotificationImage.hasImage) {
        UNNotificationAttachment *attachement1 = [UNNotificationAttachment attachmentWithIdentifier:@"com.connecthings.beaconNotificationImage" URL:placeNotificationImage.getImageURL options:nil error:nil];
        notificationContent.attachments=@[attachement1];
    }

    return notificationContent;
}

- (UILocalNotification * _Nonnull)generateNotificationForIOS9AndMinusWithPlaceNotificationImage:(PlaceNotificationImage * _Nonnull)placeNotificationImage {
    NSLog(@"create notification from app delegate");
    UILocalNotification *notification = [[UILocalNotification alloc]init];

    AdtagPlaceNotification *placeNotification = [placeNotificationImage getPlaceNotification];

    if ([placeNotification getDescription].length <= 0) {
        [notification setAlertBody:[placeNotification getTitle]];
    } else{
        [notification setAlertBody:[placeNotification getDescription]];
    }

    if (SYSTEM_VERSION_GREATER_THAN(@"7.99") && [placeNotification getTitle].length > 0) {
        [notification setAlertTitle:[placeNotification getTitle]];
    }

    return notification;
}

@end

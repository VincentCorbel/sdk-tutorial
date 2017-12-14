//
//  AsyncNotificationTask.m
//  NotificationComplete
//
//  Created by Ludovic Vimont on 27/10/2017.
//  Copyright © 2017 sarra srairi. All rights reserved.
//

#import "AsyncNotificationTask.h"
 
@import ConnectPlaceActions;

@implementation AsyncNotificationTask


- (void)launchNotificationTaskWithPlaceNotification:(AdtagPlaceNotification * _Nonnull)placeNotification displayPlaceNotificationDelegate:(id<DisplayPlaceNotificationDelegate> _Nonnull)displayPlaceNotificationDelegate {
    [displayPlaceNotificationDelegate displayPlaceNotification:[[PlaceNotificationImage alloc] initWithPlaceNotification:placeNotification]];
}

@end

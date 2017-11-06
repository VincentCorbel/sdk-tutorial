//
//  AsyncNotificationTask.m
//  NotificationComplete
//
//  Created by Ludovic Vimont on 27/10/2017.
//  Copyright © 2017 sarra srairi. All rights reserved.
//

#import "AsyncNotificationTask.h"

@import ConnectPlaceActions;
@import PromiseKit;

@implementation AsyncNotificationTask

- (AnyPromise * _Nonnull) launchNotificationTask:(id<PlaceNotification> _Nonnull)placeNotification {
    return [AnyPromise promiseWithValue:[[PlaceNotificationImage alloc] initWithPlaceNotification:placeNotification]];
}

@end

//
//  AsyncNotificationTask.m
//  NotificationComplete
//
//  Created by Ludovic Vimont on 27/10/2017.
//  Copyright © 2017 sarra srairi. All rights reserved.
//

#import "AsyncNotificationTask.h"
#import "ConnectPlaceActions-Swift.h"
#import "PromiseKit-Swift.h"

@implementation AsyncNotificationTask

- (AnyPromise * _Nonnull)launchNotificationTask:(id<PlaceNotification> _Nonnull)placeNotification {
    return [AnyPromise promiseWithResolverBlock:^(PMKResolver resolve) {
        PlaceNotificationImage *placeNotificationImage = [[PlaceNotificationImage alloc] initWithPlaceNotification:placeNotification];
        resolve(placeNotificationImage);
    }];
}

@end

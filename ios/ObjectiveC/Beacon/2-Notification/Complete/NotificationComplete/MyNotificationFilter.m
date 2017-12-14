//
//  MyNotificationFilter.m
//  NotificationComplete
//
//  Created by Olivier Stevens on 23/11/2017.
//  Copyright © 2017 sarra srairi. All rights reserved.
//

#import "MyNotificationFilter.h"

@implementation MyNotificationFilter

-(id) initWithMinTimeBetweenNotification:(double)minTimeBetweenNotification{
    self = [super init];
    if(self){
        self->minTimeBetweenNotification = (double) minTimeBetweenNotification;
        minNextTimeNotification = 0;
    }
    return self;
}

- (NSString * _Nonnull)getName {
    return @"MyNotificationFilter";
}

- (BOOL)createNewNotificationWithPlaceNotification:(id<PlaceNotification> _Nonnull)placeNotification {
    return minNextTimeNotification < CACurrentMediaTime();
}

- (BOOL)deleteCurrentNotificationWithPlaceNotification:(id<PlaceNotification>)placeNotification {
    return true;
}

- (void)onBackground {

}

- (void)onForeground {

}

- (void)onNotificationCreatedWithPlaceNotification:(id<PlaceNotification> _Nonnull)placeNotification created:(BOOL)created {

}

- (void)onNotificationDeletedWithPlaceNotification:(id<PlaceNotification>)placeNotification deleted:(BOOL)deleted {
    if (deleted) {
        minNextTimeNotification = CACurrentMediaTime() + minTimeBetweenNotification;
    }
}

- (void)loadWithUserDefaults:(NSUserDefaults * _Nonnull)userDefaults {
    minNextTimeNotification = [userDefaults doubleForKey:MIN_NEXT_TIME_NOTIFICATION];
}

- (void)saveWithUserDefaults:(NSUserDefaults * _Nonnull)userDefaults {
    [userDefaults setDouble:minNextTimeNotification forKey:MIN_NEXT_TIME_NOTIFICATION];
}

- (void)updateParametersWithParameters:(id _Nonnull)parameters {

}

@end

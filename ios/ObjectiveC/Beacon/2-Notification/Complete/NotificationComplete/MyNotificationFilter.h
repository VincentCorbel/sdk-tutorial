//
//  MyNotificationFilter.h
//  NotificationComplete
//
//  Created by Olivier Stevens on 23/11/2017.
//  Copyright © 2017 sarra srairi. All rights reserved.
//

#import <Foundation/Foundation.h>
@import ConnectPlaceActions;

#define MIN_NEXT_TIME_NOTIFICATION @"com.notification.minNextTimeNotification"

@interface MyNotificationFilter : NSObject <NotificationFilter> {
    double minTimeBetweenNotification;
    double minNextTimeNotification;
}

-(id) initWithMinTimeBetweenNotification:(double)minTimeBetweenNotification;



@end

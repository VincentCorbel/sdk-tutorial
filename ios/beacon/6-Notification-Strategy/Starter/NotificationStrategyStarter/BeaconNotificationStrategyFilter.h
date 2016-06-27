//
//  BeaconNotificationStrategyFilter.h
//  Notification
//
//  Created by Stevens Olivier on 31/05/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ATLocationBeacon/ATLocationBeacon.h>

#define MIN_NEXT_TIME_NOTIFICATION @"com.notification.minNextTimeNotification"

@interface BeaconNotificationStrategyFilter : NSObject<ATBeaconNotificationStrategyDelegate>{
    double minTimeBetweenNotification;
    double minNextTimeNotification;
}

-(id) initWithMinTimeBetweenNotification:(long)minTime;


@end

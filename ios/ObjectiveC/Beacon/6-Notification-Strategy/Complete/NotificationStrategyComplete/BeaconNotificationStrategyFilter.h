//
//  BeaconNotificationStrategyFilter.h
//  Notification
//
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

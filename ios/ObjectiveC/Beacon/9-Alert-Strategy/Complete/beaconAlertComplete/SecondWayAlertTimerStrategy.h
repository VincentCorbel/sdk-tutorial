//
//  SecondWayAlertTimerStrategy.h
//  beaconAlertComplete
//
//  Created by sarra srairi on 02/08/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//
#import <ATLocationBeacon/ATLocationBeacon.h>
#import <ATConnectionHttp/ATConnectionHttp.h>
#import <Foundation/Foundation.h>

@interface SecondWayAlertTimerStrategy : ATBeaconAlertStrategy {
    double timeToCreateAlert;
}
@property double timeToCreateAlert;;

// time in milliseconde
- (id)initWithMaxTime:(int)_maxTimeBeforeReset
DelayAfterDetectingBeaconToCreateAlert:(int)_timeToCreateAlert ;

@end

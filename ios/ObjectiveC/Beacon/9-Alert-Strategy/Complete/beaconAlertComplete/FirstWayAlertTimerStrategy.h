//
//  FirstWayAlertTimerStrategy.h
//  beaconAlertComplete
//
//  Created by sarra srairi on 02/08/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <ATLocationBeacon/ATLocationBeacon.h>
#import <ATConnectionHttp/ATConnectionHttp.h>
@interface FirstWayAlertTimerStrategy : NSObject <ATBeaconAlertStrategyDelegate>{
    
    int maxTimeBeforeReset;
    
    double timeToCreateAlert;
}

@property int maxTimeBeforeReset;

@property double timeToCreateAlert;

// time in milliseconde 
- (id)initWithMaxTime:(int)_maxTimeBeforeReset
DelayAfterDetectingBeaconToCreateAlert:(int)_timeToCreateAlert;

@end

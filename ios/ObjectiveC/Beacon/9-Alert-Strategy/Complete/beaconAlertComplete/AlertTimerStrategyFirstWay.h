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
@interface AlertTimerStrategyFirstWay : NSObject <ATBeaconAlertStrategyDelegate>{
    
    double maxTimeBeforeReset;
    
    double delayBeforeCreatingAlert;
}

@property double maxTimeBeforeReset;

@property double delayBeforeCreatingAlert;

// time in milliseconde 
- (id)initWithMaxTime:(int)_maxTimeBeforeReset
delayBeforeCreatingAlert:(int)_delayBeforeCreatingAlert;

@end

//
//  SecondWayAlertTimerStrategy.m
//  beaconAlertComplete
//
//  Created by sarra srairi on 02/08/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import "AlertTimerStrategySecondWay.h"
#import "TimeAlertStrategyParameter.h"

@implementation AlertTimerStrategySecondWay
@synthesize delayBeforeCreatingAlert;


- (id)initWithMaxTime:(int)_maxTimeBeforeReset
delayBeforeCreatingAlert:(int)_delayBeforeCreatingAlert
{
    self = [super initWithMaxTime:_maxTimeBeforeReset];
    if (self) {
        self.delayBeforeCreatingAlert = ((double) _delayBeforeCreatingAlert / 1000.0);
    }
    return self;
}

-(NSString *) getKey{
    return @"timeAlertStrategy";
}

-(bool)isConditionValid:(ATBeaconAlertParameter *) beaconParameter {
    TimeAlertStrategyParameter * strategyParameter = (TimeAlertStrategyParameter *)beaconParameter;
    return [strategyParameter timeToShowAlert] < CFAbsoluteTimeGetCurrent();
}

-(void) updateAlertParameter:(ATBeaconContent *) _beaconContent{
    TimeAlertStrategyParameter * strategyParameter = (TimeAlertStrategyParameter *) [_beaconContent beaconAlertParameter];
    double currentTime = CFAbsoluteTimeGetCurrent();
    //If we don't detect e beacon for more than 3s. we consider it's a new beacon detection
    //because the scanning period is done every 1.1s and a beacon is kept by iOs around 10s. in the beacon list when it does not detect it any more
    if([strategyParameter lastDetectionTime] + 3 < currentTime){
        strategyParameter.timeToShowAlert = currentTime + delayBeforeCreatingAlert;
    }
    strategyParameter.lastDetectionTime = currentTime;
}
 
-(Class) getBeaconAlertParameterClass {
    return [TimeAlertStrategyParameter class];
}

@end

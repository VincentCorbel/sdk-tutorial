//
//  SecondWayAlertTimerStrategy.m
//  beaconAlertComplete
//
//  Created by sarra srairi on 02/08/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import "SecondWayAlertTimerStrategy.h"

@implementation SecondWayAlertTimerStrategy
@synthesize timeToCreateAlert;


- (id)initWithMaxTime:(int)_maxTimeBeforeReset
DelayAfterDetectingBeaconToCreateAlert:(int)_timeToCreateAlert
{
     self = [super initWithMaxTime:_maxTimeBeforeReset];
    if (self) {
 
        self.timeToCreateAlert = ((double) _timeToCreateAlert / 1000)+ CFAbsoluteTimeGetCurrent();
        
    }
    return self;
}

-(NSString *) getKey{
    return @"timeAlertStrategy";
}


-(bool)isConditionValid:(ATBeaconAlertParameterProximity *) beaconParameter {
    return ([beaconParameter isInProximityForAction]);
}
 
-(BOOL)isInProximityForAction : (ATBeaconContent *)beaconContent {
    if ([beaconContent poi] == nil){
        return false;
    }
    NSString * rangeString = [beaconContent getRange];
    if (rangeString || [@""isEqualToString:rangeString]){
        if (beaconContent.beacon != nil && CFAbsoluteTimeGetCurrent() >= timeToCreateAlert){
            return YES;
        }
    }
    return false;
}


-(void) updateAlertParameter:(ATBeaconContent *) _beaconContent{
    
    ATBeaconAlertParameterProximity *beaconAlertParameterProximty = (ATBeaconAlertParameterProximity *)_beaconContent.beaconAlertParameter;
    beaconAlertParameterProximty.isInProximityForAction = [self isInProximityForAction:_beaconContent];
    
}
 
-(ATBeaconAlertParameter *) createBeaconAlertParameter {
    return ([[ATBeaconAlertParameterProximity alloc] init]);
}

@end

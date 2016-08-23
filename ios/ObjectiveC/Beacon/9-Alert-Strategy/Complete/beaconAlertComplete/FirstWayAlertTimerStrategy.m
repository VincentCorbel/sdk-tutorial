//
//  FirstWayAlertTimerStrategy.m
//  beaconAlertComplete
//
//  Created by sarra srairi on 02/08/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import "FirstWayAlertTimerStrategy.h"

@implementation FirstWayAlertTimerStrategy


@synthesize maxTimeBeforeReset,timeToCreateAlert;
- (id)initWithMaxTime:(int)_maxTimeBeforeReset
DelayAfterDetectingBeaconToCreateAlert:(int)_timeToCreateAlert
{
    self = [super init];
    if (self) {
        self.maxTimeBeforeReset = _maxTimeBeforeReset;
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

-(void) updateAlertParameter:(ATBeaconContent *) _beaconContent{
    
    ATBeaconAlertParameterProximity *beaconAlertParameterProximty = (ATBeaconAlertParameterProximity *)_beaconContent.beaconAlertParameter;
    beaconAlertParameterProximty.isInProximityForAction = [self isInProximityForAction:_beaconContent];
    
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



-(bool)isReadyForAction:(ATBeaconAlertParameter *) beaconParameter {
    return ([beaconParameter  actionStatus] == ATBeaconActionStatusWaitingForAction && beaconParameter.isConditionValid);
}

-(void)updateBeaconContent:(ATBeaconContent *)_beaconContent{
    
    if (_beaconContent.beaconAlertParameter ==nil){
        _beaconContent.beaconAlertParameter = [self createBeaconAlertParameter];
    }
    
    [self updateAlertParameter:_beaconContent];
    _beaconContent.beaconAlertParameter.isConditionValid = [self isConditionValid:_beaconContent.beaconAlertParameter];
    if ([_beaconContent.beaconAlertParameter actionStatus] == ATBeaconActionStatusActionDone){
        [self testToReseatActionIsDone:_beaconContent.beaconAlertParameter];
    }
    
    _beaconContent.beaconAlertParameter.isReadyForAction = [self isReadyForAction:_beaconContent.beaconAlertParameter];
    //    //Update each cycle -> means only a beacon that we don't see for more than maxTimeBeforeReset will be impact
    _beaconContent.beaconAlertParameter.maxTimeBeforeResetingIsActionDone = CFAbsoluteTimeGetCurrent() + maxTimeBeforeReset;
    
}

-(ATBeaconAlertParameter *) createBeaconAlertParameter {
    return ([[ATBeaconAlertParameter alloc] init]);
}


-(void)testToReseatActionIsDone:(ATBeaconAlertParameter *) strategyParameter{
    if ((![strategyParameter isConditionValid])|| (strategyParameter.maxTimeBeforeResetingIsActionDone <CFAbsoluteTimeGetCurrent() && [strategyParameter actionStatus] == ATBeaconActionStatusActionDone)){
        
        strategyParameter.actionStatus= ATBeaconActionStatusWaitingForAction;
    }
}
@end

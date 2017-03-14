//
//  FirstWayAlertTimerStrategy.m
//  beaconAlertComplete
//
//  Created by sarra srairi on 02/08/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import "AlertTimerStrategyFirstWay.h"
#import "TimeAlertStrategyParameter.h"

@implementation AlertTimerStrategyFirstWay


@synthesize maxTimeBeforeReset,delayBeforeCreatingAlert;

- (id)initWithMaxTime:(int)_maxTimeBeforeReset
delayBeforeCreatingAlert:(int)_delayBeforeCreatingAlert
{
    self = [super init];
    if (self) {
        self.maxTimeBeforeReset = ((double) _maxTimeBeforeReset) / 1000.0;
        self.delayBeforeCreatingAlert = ((double) _delayBeforeCreatingAlert / 1000.0);
         
    }
    return self;
}

-(NSString *) getKey{
    return @"timeAlertStrategy";
}

-(bool)isConditionValid:(ATBeaconAlertParameter *) beaconParameter {
    TimeAlertStrategyParameter * strategyParameter = (TimeAlertStrategyParameter *)beaconParameter;
    return strategyParameter.timeToShowAlert < CFAbsoluteTimeGetCurrent();
}

-(Class) getBeaconAlertParameterClass {
    return [TimeAlertStrategyParameter class];
}

-(bool)isReadyForAction:(ATBeaconAlertParameter *) beaconParameter {
    return ([beaconParameter  actionStatus] == ATBeaconActionStatusWaitingForAction && beaconParameter.isConditionValid);
}

-(void)updateBeaconContent:(ATBeaconContent *)_beaconContent{
    if (_beaconContent.beaconAlertParameter ==nil || [_beaconContent.beaconAlertParameter class] != [self getBeaconAlertParameterClass]){
        _beaconContent.beaconAlertParameter = [[[self getBeaconAlertParameterClass] alloc] init];
    }
    
    TimeAlertStrategyParameter * strategyParameter = (TimeAlertStrategyParameter *) [_beaconContent beaconAlertParameter];
    double currentTime = CFAbsoluteTimeGetCurrent();
    //If we d'ont detect e beacon for more than 3s. we consider it's a new beacon detection
    //because the scanning period is done every 1.1s and a beacon is kept by iOs around 10s. in the beacon list when it does not detect it any more
    if(strategyParameter.lastDetectionTime + 3 < currentTime){
        strategyParameter.timeToShowAlert = currentTime + delayBeforeCreatingAlert;
    }
    strategyParameter.lastDetectionTime = currentTime;

    _beaconContent.beaconAlertParameter.isConditionValid = [self isConditionValid:_beaconContent.beaconAlertParameter];
    if ([_beaconContent.beaconAlertParameter actionStatus] == ATBeaconActionStatusActionDone){
        [self testToReseatActionIsDone:_beaconContent.beaconAlertParameter];
    }
    
    _beaconContent.beaconAlertParameter.isReadyForAction = [self isReadyForAction:_beaconContent.beaconAlertParameter];
    //Update each cycle -> means only a beacon that we don't see for more than maxTimeBeforeReset will be impact
    _beaconContent.beaconAlertParameter.maxTimeBeforeResetingIsActionDone = CFAbsoluteTimeGetCurrent() + maxTimeBeforeReset;
}


-(void)testToReseatActionIsDone:(ATBeaconAlertParameter *) strategyParameter{
    if ((![strategyParameter isConditionValid])|| (strategyParameter.maxTimeBeforeResetingIsActionDone <
                                                   CFAbsoluteTimeGetCurrent() && [strategyParameter actionStatus] == ATBeaconActionStatusActionDone)){
        strategyParameter.actionStatus= ATBeaconActionStatusWaitingForAction;
    }
}
@end

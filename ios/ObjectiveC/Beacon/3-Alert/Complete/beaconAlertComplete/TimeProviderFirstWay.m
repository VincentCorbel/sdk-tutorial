//
//  TimeProviderFirstWay.m
//  beaconAlertComplete
//
//  Created by Connecthings on 24/11/2017.
//  Copyright © 2017 Connecthings. All rights reserved.
//

#import "TimeProviderFirstWay.h"
#import "beaconAlertComplete-Swift.h"
@import ConnectPlaceCommon;

@implementation TimeProviderFirstWay {
    double maxTimeBeforeReset;
    double delayBeforeCreation;
    TimeProviderAbsolute *timeProvider;
}

-(id) initWithMaxTimeBeforeReset:(double)maxTimeBeforeReset delayBeforeCreation:(double)delayBeforeCreation {
    self = [super init];
    if (self) {
        self->maxTimeBeforeReset = maxTimeBeforeReset;
        self->delayBeforeCreation = delayBeforeCreation;
        timeProvider = [[TimeProviderAbsolute alloc] init];
    }
    return self;
}

-(NSString *)getConditionsKey {
    return @"inAppActionTimeConditions";
}

- (NSString *)getApplicationNamespace {
    return @"beaconAlertComplete";
}

- (NSString *)getInAppActionParameterClass {
    return @"TimeConditionsParameter";
}

- (void)updateInAppActionConditionsParameter:(InAppActionConditionsParameter * _Nonnull)conditionsParameter {
    [self updateLastDetectionTime:conditionsParameter];
    conditionsParameter.isConditionValid = [self isConditionValid:conditionsParameter];
    conditionsParameter.inAppActionStatus = [self updateInAppActionStatus:conditionsParameter];
    conditionsParameter.isReadyForAction = [self isReadyForAction:conditionsParameter];
    conditionsParameter.maxTimeBeforeActionDoneReset = [self updateMaxTimeBeforeActionDoneReset:conditionsParameter];
}

-(void) updateLastDetectionTime:(InAppActionConditionsParameter *) conditionsParameter {
    TimeConditionsParameter *strategyParameter = (TimeConditionsParameter *) conditionsParameter;
    double currentTime = [timeProvider getTime];
    if (strategyParameter.lastDetectionTime + 3 < currentTime) {
        NSLog(@"delay before creating %f", delayBeforeCreation);
        strategyParameter.timeToShowAlert = currentTime + delayBeforeCreation;
    }
    strategyParameter.lastDetectionTime = currentTime + 0;
}

- (BOOL)isConditionValid:(InAppActionConditionsParameter *)conditionsParameter {
    TimeConditionsParameter *strategyParameter = (TimeConditionsParameter *) conditionsParameter;
    NSLog(@"remaining time %f",([timeProvider getTime] - strategyParameter.timeToShowAlert));
    return strategyParameter.timeToShowAlert < [timeProvider getTime];
}

- (BOOL)isReadyForAction:(InAppActionConditionsParameter *)conditionsParameter {
    return conditionsParameter.inAppActionStatus == InAppActionStatusWAITING_FOR_ACTION
    && conditionsParameter.isConditionValid;
}

- (double)updateMaxTimeBeforeActionDoneReset:(InAppActionConditionsParameter *)conditionsParameter {
    return maxTimeBeforeReset + [timeProvider getTime];
}

- (enum InAppActionStatus)updateInAppActionStatus:(InAppActionConditionsParameter *)conditionsParameter {
    if (conditionsParameter.inAppActionStatus == InAppActionStatusDONE) {
        if (!conditionsParameter.isConditionValid
        || conditionsParameter.maxTimeBeforeActionDoneReset < [timeProvider getTime ]) {
            return InAppActionStatusWAITING_FOR_ACTION;
        }
    }
    return conditionsParameter.inAppActionStatus;
}

@end

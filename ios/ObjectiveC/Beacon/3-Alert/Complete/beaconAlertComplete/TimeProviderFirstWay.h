//
//  TimeProviderFirstWay.h
//  beaconAlertComplete
//
//  Created by Connecthings on 24/11/2017.
//  Copyright © 2017 Connecthings. All rights reserved.
//

#import <Foundation/Foundation.h>
@import ConnectPlaceActions;

@interface TimeProviderFirstWay : NSObject <InAppActionConditions, InAppActionConditionsUpdater>

- (id) initWithMaxTimeBeforeReset:(double) maxTimeBeforeReset delayBeforeCreation:(double) delayBeforeCreation;

@end

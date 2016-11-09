//
//  BeaconNotificationStrategyFilter.m
//  Notification
//
//  Created by Stevens Olivier on 31/05/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import "BeaconNotificationStrategyFilter.h"

@implementation BeaconNotificationStrategyFilter

-(id) initWithMinTimeBetweenNotification:(long)minTime{
    self = [super init];
    if(self){
        minTimeBetweenNotification = minTime / 1000.0;
    }
    return self;
}

-(bool) createNewNotification:(ATBeaconContent *)newBeaconContent feedStatus:(ATRangeFeedStatus)feedStatus{
    return minNextTimeNotification < CACurrentMediaTime();
}

-(void) onNotificationIsCreated:(ATBeaconContent *)beconContent notificationStatus:(BOOL)notificationStatus{
    
}

-(bool) deleteCurrentNotification:(ATBeaconContent *)newBeaconContent feedStatus:(ATRangeFeedStatus)feedStatus{
    return true;
}

-(void) onNotificationIsDeleted:(ATBeaconContent *)beconContent notificationStatus:(BOOL)notificationStatus{
    if(notificationStatus){
        minNextTimeNotification = CACurrentMediaTime() + minTimeBetweenNotification;
    }
}

-(void) onBackground{}

-(void) onForeground{}

-(void) onStartMonitoringRegion:(ATBeaconContent *)beaconContent feedStatus:(ATRangeFeedStatus)_feedStatus{}

-(void) load:(NSUserDefaults *)dataStore{
    minNextTimeNotification = [dataStore doubleForKey:MIN_NEXT_TIME_NOTIFICATION];
}

-(void) save:(NSUserDefaults *)dataStore{
    [dataStore setDouble:minNextTimeNotification forKey:MIN_NEXT_TIME_NOTIFICATION];
}

@end

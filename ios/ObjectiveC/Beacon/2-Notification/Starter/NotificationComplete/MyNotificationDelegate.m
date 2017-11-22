//
//  MyNotificationDelegate.m
//  QuickComplete
//
//  Created by Connecthings on 09/11/2017.
//  Copyright © 2017 R&D Connecthings. All rights reserved.
//

#import "MyNotificationDelegate.h"

@implementation MyNotificationDelegate {
    AdtagBeaconManager *adtagBeaconManager;
}

-(id) initWithAdtagManager: (AdtagBeaconManager *) _adtagBeaconManager {
    self = [super init];
    if (self) {
        adtagBeaconManager = _adtagBeaconManager;
    }
    return self;
}

-(void) userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    [adtagBeaconManager didReceivePlaceNotification:response.notification.request.content.userInfo];
    completionHandler();
}

@end

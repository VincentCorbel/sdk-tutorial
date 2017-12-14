//
//  MyNotificationDelegate.h
//  QuickComplete
//
//  Created by Connecthings on 09/11/2017.
//  Copyright © 2017 R&DConnecthings. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UserNotifications;
@import AdtagLocationBeacon;

@interface MyNotificationDelegate : NSObject <UNUserNotificationCenterDelegate>

-(id) initWithAdtagManager: (AdtagBeaconManager *) _adtagBeaconManager;

@end

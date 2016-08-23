//
//  AppDelegate.h
//  tutorial.BeaconDefaultNotification
//
//  Created by Stevens Olivier on 20/04/2016.
//  Copyright © 2016 R&D connecthings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ATLocationBeacon/ATLocationBeacon.h>
#import <ATConnectionHttp/ATConnectionHttp.h>

@interface AppDelegate : ATBeaconAppDelegate <UIApplicationDelegate,ATBeaconNotificationDelegate>

@property (strong, nonatomic) UIWindow *window;


@end


//
//  AppDelegate.h
//  QuickStart
//
//  Created by sarra srairi on 22/03/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ATLocationBeacon/ATLocationBeacon.h>
#import <ATConnectionHttp/ATConnectionHttp.h>

@interface AppDelegate : ATBeaconAppDelegate <UIApplicationDelegate, ATBeaconReceiveNotificatonContentDelegate>

@property (strong, nonatomic) UIWindow *window;


@end


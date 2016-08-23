//
//  AppDelegate.h
//  BeaconRange
//
//  Created by sarra srairi on 08/08/2016.
//  Copyright © 2016 R&D connecthings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ATLocationBeacon/ATLocationBeacon.h>
#import <ATConnectionHttp/ATConnectionHttp.h>

@interface AppDelegate : ATBeaconAppDelegate <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;


@end


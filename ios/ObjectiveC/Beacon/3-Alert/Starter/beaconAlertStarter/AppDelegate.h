//
//  AppDelegate.h
//  beaconAlertStart
//
//  Created by sarra srairi on 29/03/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//
#import <ATLocationBeacon/ATLocationBeacon.h>
#import <ATConnectionHttp/ATConnectionHttp.h>
#import <UIKit/UIKit.h>

@interface AppDelegate : ATBeaconAppDelegate <UIApplicationDelegate>{
    
    
}

@property (strong, nonatomic) UIWindow *window;


@end


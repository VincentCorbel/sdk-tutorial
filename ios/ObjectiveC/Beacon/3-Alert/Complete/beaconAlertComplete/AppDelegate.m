//
//  AppDelegate.m
//  beaconAlertStart
//
//  Created by sarra srairi on 29/03/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import "AppDelegate.h"
#import "beaconAlertComplete-Swift.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    AdtagInitializer *adtagInitializer = [AdtagInitializer shared];
    [[[adtagInitializer configPlatform:AdtagPlatform.preProd] configUserWithLogin:@"__LOGIN__" password:@"__PSW__" company:@"__COMPANY__"] synchronize];
    
    [[AdtagBeaconManager shared] addInAppActionConditions:[[TimeConditionsFirstWay alloc] initWithMaxTimeBeforeReset:60000 delayBeforeCreation:60000]];

    return YES;
}

- (void) applicationWillResignActive:(UIApplication *)application {
    [[AdtagInitializer shared] onAppInBackground];
}

- (void) applicationDidBecomeActive:(UIApplication *)application {
    [[AdtagInitializer shared] onAppInForeground];
}

@end

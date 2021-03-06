//
//  AppDelegate.m
//  beaconAlertStart
//
//  Created by sarra srairi on 29/03/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import "AppDelegate.h"
#import "beaconAlertComplete-Swift.h"
#import "TimeProviderFirstWay.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    AdtagInitializer *adtagInitializer = [AdtagInitializer shared];
    [[[adtagInitializer configPlatform:AdtagPlatform.preProd] configUserWithLogin:@"__LOGIN__" password:@"__PSWD__" company:@"__COMPANY__"] synchronize];
    [[AdtagBeaconManager shared] addInAppActionConditions:[[TimeConditions alloc] initWithMaxTimeBeforeReset:60 delayBeforeCreation:60]];
    //[[AdtagBeaconManager shared] addInAppActionConditions:[[TimeProviderFirstWay alloc] initWithMaxTimeBeforeReset:60 delayBeforeCreation:30]];

    return YES;
}

- (void) applicationWillResignActive:(UIApplication *)application {
    [[AdtagInitializer shared] onAppInBackground];
}

- (void) applicationDidBecomeActive:(UIApplication *)application {
    [[AdtagInitializer shared] onAppInForeground];
}

@end

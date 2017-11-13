//
//  AppDelegate.m
//  beaconAlertStart
//
//  Created by sarra srairi on 29/03/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    AdtagInitializer *adtagInitializer = [AdtagInitializer shared];
    [[[adtagInitializer configPlatform:AdtagPlatform.preProd] configUserWithLogin:@"__LOGIN__" password:@"__PSW__" company:@"__COMPANY__"] synchronize];
    
    return YES;
}

- (void) applicationWillResignActive:(UIApplication *)application {
    [[AdtagInitializer shared] onAppInBackground];
}

- (void) applicationDidBecomeActive:(UIApplication *)application {
    [[AdtagInitializer shared] onAppInForeground];
}

@end

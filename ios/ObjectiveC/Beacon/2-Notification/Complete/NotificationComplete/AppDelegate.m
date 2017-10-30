//
//  AppDelegate.m
//  Notification
//
//  Created by sarra srairi on 22/03/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewControllerBeacon.h"
#import "MyBeaconNotificationBuilder.h"
#import "AsyncNotificationTask.h"

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface AppDelegate ()

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    AdtagInitializer *adtagInitializer = [AdtagInitializer shared];
    [[[adtagInitializer configPlatformWithPlatform: AdtagPlatform.preProd] configUserWithLogin:@"" password:@"" company:@""] synchronize];
    [[AdtagBeaconManager shared] registerNotificationBuilder: [[MyBeaconNotificationBuilder alloc] init]];
    [[AdtagBeaconManager shared] registerNotificationTask: [AsyncNotificationTask alloc]];

    if (SYSTEM_VERSION_LESS_THAN(@"10.0") && [application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [application registerUserNotificationSettings: [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }

    return YES;
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [[AdtagBeaconManager shared] didReceivePlaceNotification: [notification userInfo]];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end

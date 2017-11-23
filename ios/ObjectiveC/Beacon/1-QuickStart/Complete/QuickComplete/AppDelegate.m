//
//  AppDelegate.m
//  QuickStart
//
//  Created by sarra srairi on 22/03/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import "AppDelegate.h"
#import "MyNotificationDelegate.h"
@import AdtagLocationBeacon;

#define SYSTEM_VERSION_EQUAL_TO(v)                  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedSame)
#define SYSTEM_VERSION_GREATER_THAN(v)              ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedDescending)
#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN(v)                 ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)
#define SYSTEM_VERSION_LESS_THAN_OR_EQUAL_TO(v)     ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedDescending)

@interface AppDelegate ()

@end

@implementation AppDelegate {
    AdtagInitializer *adtagInitializer;
    AdtagBeaconManager *adtagBeaconManager;
    MyNotificationDelegate *myNotificationDelegate;
}


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    adtagInitializer = [AdtagInitializer shared];
    [[[adtagInitializer configPlatform: AdtagPlatform.preProd]
        configUserWithLogin:@"__LOGIN__" password:@"__PSWD__" company:@"__COMPANY__"] synchronize];
    adtagBeaconManager = [AdtagBeaconManager shared];
    if (SYSTEM_VERSION_LESS_THAN(@"10.0") && [application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound categories:nil]];
    } else {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        //The request can be done as well in a viewController which allows to display a message if the user refuse to receive notifications
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  if (!error) {
                                      NSLog(@"request authorization succeeded!");
                                  }
                              }];
        myNotificationDelegate = [[MyNotificationDelegate alloc] initWithAdtagManager:adtagBeaconManager];
        center.delegate = myNotificationDelegate;
    }
    [adtagBeaconManager registerReceiveNotificatonContentDelegate:self];
    return YES;
}

- (void) applicationWillResignActive:(UIApplication *)application {
    [adtagInitializer onAppInBackground];
}

- (void) applicationDidBecomeActive:(UIApplication *)application {
    [adtagInitializer onAppInForeground];
}

- (void) application:(UIApplication *)application
didReceiveLocalNotification:(UILocalNotification *)notification {
    [adtagBeaconManager didReceivePlaceNotification:[notification userInfo]];
}

- (void) didReceivePlaceNotification:(AdtagPlaceNotification *)placeNotification {
    //Do action with this object when the notification is clicked, a beacon notification
    NSLog(@"Do an action when the beacon notification is clicked - for example open a controller");
}

- (void) didReceiveWelcomeNotification:(AdtagPlaceWelcomeNotification *)welcomeNotification {
    //Do action with this object when the notification is clicked, from welcome notification
    NSLog(@"Do an action when the beacon notification is clicked - for example open a controller");
}


@end

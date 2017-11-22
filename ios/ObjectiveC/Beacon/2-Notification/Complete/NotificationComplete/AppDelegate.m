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
#import "MyNotificationDelegate.h"

#define SYSTEM_VERSION_LESS_THAN(v) ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] == NSOrderedAscending)

@interface AppDelegate () {
    AdtagInitializer *adtagInitializer;
    AdtagBeaconManager *adtagBeaconManager;
    MyNotificationDelegate *myNotificationDelegate;
}

@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    adtagInitializer = [AdtagInitializer shared];
    [[[adtagInitializer configPlatform:AdtagPlatform.preProd] configUserWithLogin:@"__LOGIN__" password:@"__PSWD__" company:@"__COMPANY__"] synchronize];

    adtagBeaconManager = [AdtagBeaconManager shared];
    [adtagBeaconManager registerReceiveNotificatonContentDelegate:self];
    [adtagBeaconManager registerNotificationBuilder: [[MyBeaconNotificationBuilder alloc] init]];
    [adtagBeaconManager registerNotificationTask: [AsyncNotificationTask alloc]];

    if (SYSTEM_VERSION_LESS_THAN(@"10.0") && [application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeSound categories:nil]];
    } else {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        //The request can be done as well in a viewController which allows to display a message if the user refuse the receive notifications
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionSound | UNAuthorizationOptionAlert)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  if (!error) {
                                      NSLog(@"request authorization succeeded!");
                                  }
                              }];
        myNotificationDelegate = [[MyNotificationDelegate alloc] initWithAdtagManager:adtagBeaconManager];
        center.delegate = myNotificationDelegate;
    }

    return YES;
}

- (void) applicationWillResignActive:(UIApplication *)application {
    [adtagInitializer onAppInBackground];
}

- (void) applicationDidBecomeActive:(UIApplication *)application {
    [adtagInitializer onAppInForeground];
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification {
    [[AdtagBeaconManager shared] didReceivePlaceNotification: [notification userInfo]];
}

- (void) didReceivePlaceNotification:(AdtagPlaceNotification *)placeNotification {
    //Do action with this object when the notification is clicked, a beacon notification
    NSLog(@"Do an action when the beacon notification is clicked - for example open a controller");
    //Fast way to code it
    NSDictionary* dict = [NSDictionary dictionaryWithObject: placeNotification forKey:@"placeNotification"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"placeNotification" object:nil userInfo:dict];
}

- (void) didReceiveWelcomeNotification:(AdtagPlaceWelcomeNotification *)welcomeNotification {
    //Do action with this object when the notification is clicked, from welcome notification
    NSLog(@"Do an action when the beacon notification is clicked - for example open a controller");
    //Fast way to code it
    NSDictionary* dict = [NSDictionary dictionaryWithObject: welcomeNotification forKey:@"placeNotification"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"placeNotification" object:nil userInfo:dict];
}


@end

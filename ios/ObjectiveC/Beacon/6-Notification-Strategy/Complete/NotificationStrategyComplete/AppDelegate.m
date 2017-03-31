//
//  AppDelegate.m
//  Notification
//
//  Created by sarra srairi on 22/03/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewControllerBeacon.h"
#import "BeaconNotificationStrategyFilter.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    
    NSString *USER = @"User_cbeacon";
    NSString *PASS = @"fSKbCEvCDCbYTDlk";
    NSString *COMPANY = @"ccbeacondemo";
    
    [[[ATAdtagInitializer sharedInstance] configureUrlType:ATUrlTypeDev andLogin:USER andPassword:PASS andCompany:COMPANY] synchronize];
    [ATLogManager initInstanceWithInformation:30  MaxLogInDbBeforSending:200 maxNumberToSendToServer:200 sendLogWifiOnly:false];
    
    [self addNotificationStrategy:[[BeaconNotificationStrategyFilter alloc] initWithMinTimeBetweenNotification: 5 * 1000 * 60]];
    
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    return YES;
}


-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    [super application:application didReceiveLocalNotification:notification];
}

// if you implement didBeacomeActive you should add a super call, if you don't just remove all the method

- (void)applicationDidBecomeActive:(UIApplication *) application{
    [super applicationDidBecomeActive:application];
    application.applicationIconBadgeNumber = 0;
}

-(void) didReceiveBeaconNotification:(ATBeaconContent *) _beaconContent{
    NSDictionary* dict = [NSDictionary dictionaryWithObject: _beaconContent forKey:@"beaconContent"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BeaconNotification" object:nil userInfo:dict];
}


-(void) didReceiveBeaconWelcomeNotification:(id<ATBeaconWelcomeNotification>) _welcomeNotificationContent {
    
}

@end

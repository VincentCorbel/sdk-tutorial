//
//  AppDelegate.m
//  Notification
//
//  Created by sarra srairi on 22/03/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import "AppDelegate.h"
#import "ViewControllerBeacon.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    // Override point for customization after application launch.
    // HELP:
    // init the adtag platforme with the
    // ** user Login : Login delivred by the Connecthings staff
    // ** user Password : Password delivred by the Connecthings staff
    // ** user Compagny : ....
    // ** beaconUuid : - UUID beacon number devivred by the Connecthings staff
    //
    [self initAdtagInstanceWithUrlType:ATUrlTypeItg userLogin:@"****" userPassword:@"****" userCompany:@"****" beaconUuid:@"********-****-****-****-************"];
    [[[ATAdtagInitializer sharedInstance] configureUrlType:__UrlType__ andLogin:@"__YourLogin__" andPassword:@"__YourPassword__" andCompany:@"__YourCompany__"] synchronize];
    
    return YES;
}

// if you implement didBeacomeActive you should add a super call
// if you don't just remove all the method
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [super applicationDidBecomeActive:application];
}



-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    [super application:application didReceiveLocalNotification:notification];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}


@end

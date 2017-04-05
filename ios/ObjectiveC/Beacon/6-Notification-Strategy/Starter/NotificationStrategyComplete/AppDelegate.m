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
    /* ** Required -- used to initialize and setup the SDK
     *
     *
     *
     * If you have followed our SDK quickstart guide, you won't need to re-use this method, but you should add the parameters values.
     * -- 1- Platform : ATUrlTypePreprod  = > Pre-production Platform
     *                  ATUrlTypeProd     = > Production Platform
     *                  ATUrlTypeDemo     = > Demo Platform
     *
     * Key/Value are related to the selected Platform
     * -- 2- user Login : Login delivred by the Connecthings staff
     * -- 3- user Password : Password delivred by the Connecthings staff
     * -- 4- user Compagny : Define the compagny name
     * -- 5- beaconUuid : - UUID beacon number delivred by the Connecthings staff
     * --
     *
     * All other SDK methods must be called after this one, because they won't exist until you do.
     */
    if([launchOptions objectForKey:@"UIApplicationLaunchOptionsLocationKey"]){
        [[[ATAdtagInitializer sharedInstance] configureUrlType:__UrlType__ andLogin:@"__YourLogin__" andPassword:@"__YourPassword__" andCompany:@"__YourCompany__"] synchronize];
    }
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    
    return YES;
}


-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    [super application:application didReceiveLocalNotification:notification];
}
// if you implement didBeacomeActive you should add a super call
// if you don't just remove all the method

- (void)applicationDidBecomeActive:(UIApplication *)application{
    [super applicationDidBecomeActive:application];
    application.applicationIconBadgeNumber = 0;
}


-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
}

@end

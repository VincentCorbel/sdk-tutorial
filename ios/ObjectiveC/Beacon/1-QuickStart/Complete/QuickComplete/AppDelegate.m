//
//  AppDelegate.m
//  QuickStart
//
//  Created by sarra srairi on 22/03/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import "AppDelegate.h"

@interface AppDelegate ()

@end

@implementation AppDelegate

/*** MUST KNOW !!
  IF YOU WILL IMPLEMENT THE applicationDidBecomeActive METHOD YOU SHOULD ADD [super applicationDidBecomeActive:application];
    -   the super method will activate the range in your project
*/

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [super application:application didFinishLaunchingWithOptions:launchOptions];
    
     [[[ATAdtagInitializer sharedInstance] configureUrlType:__PLATFORM__ andLogin:@"__USER__" andPassword:@"__PSWD__" andCompany:@"__COMPANY__"] synchronize];
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    return YES;
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    [super applicationDidBecomeActive:application];
}


-(void) didReceiveBeaconNotification:(ATBeaconContent *)_beaconContent{
    // redirect to the correct ViewController - in our case there is just one ViewController, so it's not necessary
}

@end

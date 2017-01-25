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
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
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
    NSArray *uuids = @[@"B0462602-CBF5-4ABB-87DE-B05340DCCBC5"];
    [self initAdtagInstanceWithUrlType:ATUrlTypeDev userLogin:@"User_cbeacon" userPassword:@"fSKbCEvCDCbYTDlk" userCompany:@"ccbeacondemo" beaconArrayUuids:uuids];
    
    [self registerAsyncBeaconNotificationDelegate:[[ATAsyncBeaconNotificationImageCreator alloc] initWithCreateBeaconNotification:[[MyBeaconNotificationBuilder alloc] init]]];
  if([launchOptions objectForKey:@"UIApplicationLaunchOptionsLocationKey"]){
    }
    //To add the application to the notification center untill ios9
    if (!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0") && [application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
   
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

-(void) didReceiveBeaconNotification:(ATBeaconContent *)_beaconContent{
    //Open the view controller associate to the notification
    //You can use [_beaconContent getUri] to match with a deeplink
    //Here a fast an simple exemple
    NSDictionary* dict = [NSDictionary dictionaryWithObject: _beaconContent forKey:@"beaconContent"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BeaconNotification" object:nil userInfo:dict];
    
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

@end

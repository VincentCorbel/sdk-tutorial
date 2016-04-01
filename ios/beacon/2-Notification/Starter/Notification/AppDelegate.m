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
  
    // HELP:
    // init the adtag platforme with the
    // ** user Login : Login delivred by the Connecthings staff
    // ** user Password : Password delivred by the Connecthings staff
    // ** user Compagny : ....
    // ** beaconUuid : - UUID beacon number devivred by the Connecthings staff
    //
    [self initAdtagInstanceWithUrlType:ATUrlTypeDemo userLogin:@"****" userPassword:@"*****" userCompany:@"****" beaconUuid:@"*****-****-****-****-**********"];
   
    //To add the application to the notification center
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
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
    
    if ([UIApplication sharedApplication].applicationState!=UIApplicationStateActive) {
        // do something when users click on notification
        UIStoryboard* storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        ViewControllerBeacon *BeaconController = [storyboard instantiateViewControllerWithIdentifier:@"beaconController"];
        /*
         **  You can retreive beaconContent notification with this line of code
         
         ATBeaconContent *beaconContent = [adtagBeaconManager getNotificationBeaconContent];
         
         ** You can also send Notification information to your BeaconController with the method beyond
         
         [BeaconController load:[adtagBeaconManager getNotificationBeaconContent] redirectType:ATBeaconRedirectTypeNotification from:nil];
         */
        ATBeaconContent *beaconContent = [adtagBeaconManager getNotificationBeaconContent];
        [BeaconController load:beaconContent redirectType:ATBeaconRedirectTypeNotification from:nil];
        UINavigationController *nav = [storyboard instantiateViewControllerWithIdentifier:@"nav"];
        [nav pushViewController:BeaconController animated:YES];
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}

-(UILocalNotification *)createNotification:(ATBeaconContent *)_beaconContent{
 
}

@end

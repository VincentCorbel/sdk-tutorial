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
    
    // Override point for customization after application launch.
    // HELP:
    // init the adtag platforme with the
    // ** user Login : Login delivred by the Connecthings staff
    // ** user Password : Password delivred by the Connecthings staff
    // ** user Compagny : ....
    // ** beaconUuid : - UUID beacon number devivred by the Connecthings staff
    //
    [self initAdtagInstanceWithUrlType:ATUrlTypeItg userLogin:@"****" userPassword:@"****" userCompany:@"****" beaconUuid:@"********-****-****-****-************"];
    
    //Avoid to replace the current notification if the next notification has the same content for the {category, field} value.
    // In this case, if the current beacon notification and the new beacon notification has the same beacon notification title,
    // the current beacon notification is not replaced by a notification associated to the new beacon.
    //[self addNotificationStrategy:[[ATBeaconNotificationStrategySpamRegionFilter alloc] initWithCategoryAndField:@"beacon-notification" field:@"title"]];
    //Limit the number of notifications in a lapse time : in our case the application won't create more than 2 beacon notifications each hours
    //[self addNotificationStrategy:[[ATBeaconNotificationStrategySpamMaxFilter alloc] initWithNotificationMaxNumber:2 timeBtwNotification:60 * 1000 * 60]];
    //Permit to define :
    // - a time to wait before displaying a first notification after the application goes to background (in our exemple 10 minutes)
    // - a time to wait before displaying a new beacon notification (in our exemples 20 minutes
    //[self addNotificationStrategy:[[ATBeaconNotificationStrategySpamTimeFilter alloc] initWithMinTimeBeforeCreatingNotificationWhenAppEnterInBackground:60 * 1000 minTimeBetweenTwoNotification:60 * 1000 * 20]];
    //To add the application to the notification center/Users/ssr/Desktop/FORGE/beacon-tutorial/ios/Beacon/2-Notification/NotificationComplete/Notification/AppDelegate.m
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


-(void)application:(UIApplication *)application didReceiveRemoteNotification:(NSDictionary *)userInfo{
    
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    
    if ([UIApplication sharedApplication].applicationState!=UIApplicationStateActive) {
        // do something when users click on notification
        ATBeaconContent *beaconContent = [adtagBeaconManager getNotificationBeaconContent];
        NSDictionary* dict = [NSDictionary dictionaryWithObject: beaconContent forKey:@"beaconContent"];
        [[NSNotificationCenter defaultCenter] postNotificationName:@"LocalNotificationMessageReceivedNotification" object:nil userInfo:dict];
    }
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}
-(UILocalNotification *)createNotification:(ATBeaconContent *)_beaconContent{
    
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    [notification setAlertBody:[_beaconContent getNotificationDescription]];
    
    if(SYSTEM_VERSION_GREATER_THAN(@"7.99")){
        [notification setAlertTitle:[_beaconContent getAlertTitle]];
    }
    [[UIApplication sharedApplication] presentLocalNotificationNow: notification];
    return notification;
}


@end

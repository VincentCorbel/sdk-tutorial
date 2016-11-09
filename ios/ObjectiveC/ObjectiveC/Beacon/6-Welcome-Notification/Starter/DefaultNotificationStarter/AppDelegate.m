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
    [self initAdtagInstanceWithUrlType:ATUrlTypeItg userLogin:@"****" userPassword:@"****" userCompany:@"****" beaconUuid:@"********-****-****-****-************"];
    
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
    
        NSDictionary *dict = nil;
        ATBeaconContent *beaconContent = [adtagBeaconManager getNotificationBeaconContent];
        dict = [NSDictionary dictionaryWithObject:beaconContent forKey:@"beaconContent"];
        
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
    ILog(@"create notification from app delegate");
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    if(SYSTEM_VERSION_GREATER_THAN(@"7.99")){
        [notification setAlertTitle:[_beaconContent getAlertTitle]];
    }
    [notification setAlertBody:[_beaconContent getNotificationDescription]];
    [[UIApplication sharedApplication] presentLocalNotificationNow: notification];
    return notification;
}




@end

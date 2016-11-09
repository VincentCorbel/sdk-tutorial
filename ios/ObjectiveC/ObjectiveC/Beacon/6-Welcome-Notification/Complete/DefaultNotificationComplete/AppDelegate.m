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
    
    [self initAdtagInstanceWithUrlType:ATUrlTypeProd userLogin:@"**Login**" userPassword:@"**Password***" userCompany:@"***COMPANY***" beaconUuid:@"***UUID***"];
    [self addWelcomeNotification:[[ATBeaconWelcomeNotification alloc] initTitle:@"Nice Welcome Notification" description:@"Good news: You have got network" minDisplayTime:1000 * 60 * 2 welcomeNotificationType:ATBeaconWelcomeNotificationTypeNetworkOn]];
    [self addWelcomeNotification:[[ATBeaconWelcomeNotification alloc] initTitle:@"Nice Welcome Notification" description:@"No network? Lucky you are, a free wifi is available!" minDisplayTime:1000 * 60 * 2 welcomeNotificationType:ATBeaconWelcomeNotificationTypeNetworkOff]];

    
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
        
        /*
         **  You can retreive beaconContent notification with this line of code
         ATBeaconContent *beaconContent = [adtagBeaconManager getNotificationBeaconContent];
         ** You can also send Notification information to your BeaconController with the method beyond
         */
        
        bool fromDefaultNotification = notification.userInfo != nil && [[notification.userInfo objectForKey:@"isWelcomeNotification"] boolValue];
        if(fromDefaultNotification){
            
            NSDictionary* dict = [NSDictionary dictionaryWithObject: NSLocalizedString(@"beacon_default_notification", @"") forKey:@"message"];
            
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LocalNotificationMessageReceivedNotification" object:nil userInfo:dict];
        }else{
            ATBeaconContent *beaconContent = [adtagBeaconManager getNotificationBeaconContent];
            NSString *message = [beaconContent getNotificationDescription];
            NSDictionary* dict = [NSDictionary dictionaryWithObject: [NSString stringWithFormat:NSLocalizedString(@"beacon_content", nil), message] forKey:@"message"];
        
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LocalNotificationMessageReceivedNotification" object:nil userInfo:dict];
        }
        
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

-(UILocalNotification *)createWelcomeNotification:(ATBeaconWelcomeNotification*) _beaconWelcomeNotification{
    ILog(@"create notification from app delegate");
    UILocalNotification *notification = [[UILocalNotification alloc]init];
    if(SYSTEM_VERSION_GREATER_THAN(@"7.99")){
        [notification setAlertTitle:[_beaconWelcomeNotification title]];
    }
    [notification setAlertBody:[_beaconWelcomeNotification description]];
    NSMutableDictionary *infoDict = [[NSMutableDictionary alloc] init];
    [infoDict setObject:[NSNumber numberWithBool:TRUE]  forKey:@"isWelcomeNotification"];
    [notification setUserInfo:infoDict];
    [[UIApplication sharedApplication] presentLocalNotificationNow: notification];
    return notification;
}

@end

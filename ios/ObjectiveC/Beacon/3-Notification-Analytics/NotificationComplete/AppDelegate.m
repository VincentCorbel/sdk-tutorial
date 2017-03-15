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
    NSArray *uuids = @[@"**********UUID**********"];
                       [self initAdtagInstanceWithUrlType:ATUrlTypeItg userLogin:@"***LOGIN***" userPassword:@"****PASSWORD****" userCompany:@"****COMPAGNY****" beaconArrayUuids:uuids];
    
  if([launchOptions objectForKey:@"UIApplicationLaunchOptionsLocationKey"]){
    }
    //To add the application to the notification center
    if ([application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    
    [[ATBeaconManager sharedInstance] registerNotificationContentDelegate:self];
    return YES;
}

// if you implement didBeacomeActive you should add a super call
// if you don't just remove all the method
- (void)applicationDidBecomeActive:(UIApplication *)application {
    [super applicationDidBecomeActive:application];
}



-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    // Allow send log when notification is clicked through
    [super application:application didReceiveLocalNotification:notification];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
}

- (void)applicationWillTerminate:(UIApplication *)application {
}
-(UILocalNotification *)createNotification:(ATBeaconContent *)_beaconContent {
    if (_beaconContent) {
        ILog(@"create notification from app delegate");
        UILocalNotification *notification = [[UILocalNotification alloc]init];
        [notification setAlertBody:[_beaconContent getNotificationDescription]];
        if(SYSTEM_VERSION_GREATER_THAN(@"7.99")){
            [notification setAlertTitle:[_beaconContent getAlertTitle]];
        }
        
        NSDictionary *infoDict = [NSDictionary dictionaryWithObject:[_beaconContent toJSONString] forKey: KEY_NOTIFICATION_CONTENT];
        [notification setUserInfo:infoDict];
        
        [[UIApplication sharedApplication] presentLocalNotificationNow: notification];
 
        return notification;
        
    }
    return nil;
}
-(void)didReceiveNotificationContentReceived:(ATBeaconContent *)_beaconContent {
    if (_beaconContent) {
        
        if ([UIApplication sharedApplication].applicationState!=UIApplicationStateActive) {
            NSDictionary* dict = [NSDictionary dictionaryWithObject: _beaconContent forKey:@"beaconContent"];
            [[NSNotificationCenter defaultCenter] postNotificationName:@"LocalNotificationMessageReceivedNotification" object:nil userInfo:dict];
        }
    }
}

-(void)didReceiveWelcomeNotificationContentReceived:(ATBeaconWelcomeNotification *)_welcomeNotificationContent {
}

 
@end

//
//  AppDelegate.m
//  WelcomeNotification
//
//  Created by sarra srairi on 20/12/2016.
//  Copyright © 2016 com.connecthings. All rights reserved.
//

#import "AppDelegate.h"
#import "MyBeaconWelcomeNotificationBuilder.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
    
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
    NSArray *uuids = @[@"__UID__"];
    [self initAdtagInstanceWithUrlType:ATUrlTypeDev userLogin:@"__LOGIN__" userPassword:@"__PSWD__" userCompany:@"__COMPANY__" beaconArrayUuids:uuids];
    
    // [self disableNotifications];
    ATBeaconWelcomeNotification *welcomeNotificationOn = [[ATBeaconWelcomeNotification alloc] initTitle:@"Nice Welcome notification" description:@"Good news: You have got network" picture:@"wn_on.png" minDisplayTime: 1000 * 60 *5 welcomeNotificationType:ATBeaconWelcomeNotificationTypeNetworkOn];
    [self addWelcomeNotification:welcomeNotificationOn];
    ATBeaconWelcomeNotification *welcomeNotificationOff = [[ATBeaconWelcomeNotification alloc] initTitle:@"Nice Welcome notification" description:@"No network? Lucky you are, a free wifi is available!" picture:@"wn_off.png" minDisplayTime: 1000 * 60 *5 welcomeNotificationType:ATBeaconWelcomeNotificationTypeNetworkOff];
    [self addWelcomeNotification:welcomeNotificationOff];
    
    [self registerAsyncBeaconWelcomeNotificationDelegate:[[ATAsyncBeaconWelcomeNotificationImageCreator alloc] initWithWelcomeNotificationImageBuilder:[[MyBeaconWelcomeNotificationBuilder alloc] init]]];
    if([launchOptions objectForKey:@"UIApplicationLaunchOptionsLocationKey"]){}
    
    //To add the application to the notification center
    if (!SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0") && [application respondsToSelector:@selector(registerUserNotificationSettings:)]) {
        [application registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound categories:nil]];
    }
    return YES;
}

-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification{
    [super application:application didReceiveLocalNotification:notification];
}

-(void)didReceiveBeaconNotification:(ATBeaconContent *)_beaconContent {
    //Simple way to redirect to a ViewController - not the best
    NSDictionary* dict = [NSDictionary dictionaryWithObject: _beaconContent forKey:@"beaconContent"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BeaconNotification" object:nil userInfo:dict];
}

-(void)didReceiveBeaconWelcomeNotification:(ATBeaconWelcomeNotification *)_welcomeNotificationContent {
    //Simple way to redirect to a ViewController - not the best
    NSDictionary* dict = [NSDictionary dictionaryWithObject: _welcomeNotificationContent forKey:@"welcomeNotification"];
    [[NSNotificationCenter defaultCenter] postNotificationName:@"BeaconWelcomeNotification" object:nil userInfo:dict];
}

- (void)applicationDidBecomeActive:(UIApplication *)application{
    [super applicationDidBecomeActive:application];
    application.applicationIconBadgeNumber = 0;
}

 

@end

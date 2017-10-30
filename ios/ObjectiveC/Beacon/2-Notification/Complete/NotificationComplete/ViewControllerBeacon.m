//
//  ViewController.m
//  Notification
//
//  Created by sarra srairi on 22/03/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import "ViewControllerBeacon.h"
#import <UserNotifications/UserNotifications.h>

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

@interface ViewControllerBeacon ()

@end

@implementation ViewControllerBeacon
@synthesize txtMessage;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.txtMessage.text = NSLocalizedString(@"beacon_content_empty", @"");
   
    if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"10.0")) {
        UNUserNotificationCenter *center = [UNUserNotificationCenter currentNotificationCenter];
        [center requestAuthorizationWithOptions:(UNAuthorizationOptionBadge | UNAuthorizationOptionSound | UNAuthorizationOptionAlert)
                              completionHandler:^(BOOL granted, NSError * _Nullable error) {
                                  if (!error) {
                                      NSLog(@"request authorization succeeded!");
                                  }
                              }];
    }
    
    [[AdtagBeaconManager shared] registerReceiveNotificatonContentDelegate:self];
}

-(void)viewWillAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}



- (void) didReceivePlaceNotificationWithPlaceNotification:(id<PlaceNotification> _Nonnull)placeNotification {
    [self remoteNotificationReceived:placeNotification];
}
    
- (void) didReceiveWelcomeNotificationWithWelcomeNotification:(id<PlaceWelcomeNotification> _Nonnull)welcomeNotification {
    [self remoteNotificationReceived:welcomeNotification];
}
    
- (void) remoteNotificationReceived:(id<PlaceNotification> _Nonnull) placeNotification {
    self.txtMessage.text = [placeNotification getTitle];
    [self.txtMessage setNeedsDisplay];
 }

@end

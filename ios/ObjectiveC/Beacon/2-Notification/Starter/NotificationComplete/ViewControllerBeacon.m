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
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(remoteNotificationReceived:) name:@"placeNotification"
                                               object:nil];

}

-(void)viewWillAppear:(BOOL)animated {
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) remoteNotificationReceived:(NSNotification *)notification {
    id<PlaceNotification> placeNotification = (id<PlaceNotification> _Nonnull) [notification.userInfo objectForKey:@"placeNotification"];
    self.txtMessage.text = [placeNotification getTitle];
    [self.txtMessage setNeedsDisplay];
 }

@end

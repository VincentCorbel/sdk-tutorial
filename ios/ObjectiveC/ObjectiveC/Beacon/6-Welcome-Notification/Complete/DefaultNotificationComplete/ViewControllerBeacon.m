//
//  ViewController.m
//  tutorial.BeaconDefaultNotification
//
//  Created by Stevens Olivier on 20/04/2016.
//  Copyright © 2016 R&D connecthings. All rights reserved.
//

#import "ViewControllerBeacon.h"

@interface ViewControllerBeacon ()

@end

@implementation ViewControllerBeacon

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    self.labelNotification.text = NSLocalizedString(@"beacon_content_empty", @"");
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(remoteNotificationReceived:) name:@"LocalNotificationMessageReceivedNotification"
                                               object:nil];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//Method to retreive notification BeaconContent from the AppDelegate
- (void)remoteNotificationReceived:(NSNotification *)notification{
    if( [notification.userInfo objectForKey:@"beaconContent"] == nil ){
        ATBeaconWelcomeNotification *welcomeNotification =[notification.userInfo objectForKey:@"beaconWelcomeNotification"];
        self.labelNotification.text = NSLocalizedString(@"beacon_welcome_notification", nil);
        [[ATBeaconManager sharedInstance] sendRedictLog:welcomeNotification from:@"notification"];
    }else{
        ATBeaconContent *beaconContent =[notification.userInfo objectForKey:@"beaconContent"];
        self.labelNotification.text = NSLocalizedString(@"beacon_content",[beaconContent getNotificationTitle]);
        [[ATBeaconManager sharedInstance] sendRedictLog:beaconContent redirectType:ATBeaconRedirectTypeNotification from:@"notification"];
    }

    [self.labelNotification setNeedsDisplay];
}

@end

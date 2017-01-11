//
//  ViewController.m
//  Notification
//
//  Created by sarra srairi on 22/03/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import "ViewControllerBeacon.h"

@interface ViewControllerBeacon ()

@end

@implementation ViewControllerBeacon
@synthesize txtMessage;

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.txtMessage.text = NSLocalizedString(@"beacon_content_empty", @"");
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(remoteNotificationReceived:) name:@"BeaconNotification"
                                               object:nil];
    // Do any additional setup after loading the view, typically from a nib.
}
-(void)viewWillAppear:(BOOL)animated{
    //self.txtMessage.text = messageString;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//Method to retreive notification BeaconContent from the AppDelegate
- (void)remoteNotificationReceived:(NSNotification *)notification{
    ATBeaconContent *beaconContent = [notification.userInfo objectForKey:@"beaconContent"];
    self.txtMessage.text = [beaconContent getNotificationTitle];
    [self.txtMessage setNeedsDisplay];
}

@end

//
//  ViewController.m
//  WelcomeNotification
//
//  Created by sarra srairi on 20/12/2016.
//  Copyright © 2016 com.connecthings. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // self.txtMessage.text = NSLocalizedString(@"beacon_content_empty", @"");
    
    // Do any additional setup after loading the view, typically from a nib.
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(remoteNotificationReceived:) name:@"BeaconNotification"
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(remoteWelcomeNotificationReceived:) name:@"BeaconWelcomeNotification"
                                               object:nil];
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

//Method to retreive notification BeaconContent from the AppDelegate
- (void)remoteWelcomeNotificationReceived:(NSNotification *)notification{
    ATBeaconWelcomeNotification *welcomeNotification = [notification.userInfo objectForKey:@"welcomeNotification"];
    self.txtMessage.text = [welcomeNotification title];
    [self.txtMessage setNeedsDisplay];
}

@end

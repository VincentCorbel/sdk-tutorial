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
    
    [[ATBeaconManager sharedInstance] registerNotificationContentDelegate:self];
    
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
    
}

-(void)didReceiveNotificationContentReceived:(ATBeaconContent *)_beaconContent {
    if (_beaconContent) {
        self.txtMessage.text = [_beaconContent getNotificationTitle];
        [self.txtMessage setNeedsDisplay];
    }
}

-(void)didReceiveWelcomeNotificationContentReceived:(ATBeaconWelcomeNotification *)_welcomeNotificationContent {
    
    if (_welcomeNotificationContent) {
        self.txtMessage.text = _welcomeNotificationContent.description;
        [self.txtMessage setNeedsDisplay];
    }
}

@end

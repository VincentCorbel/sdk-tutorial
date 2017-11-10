//
//  ViewController.m
//  QuickStart
//
//  Created by sarra srairi on 22/03/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()

@end

@implementation ViewController {
    NSString *feedStatusString;
    AdtagBeaconManager *beaconManager;
    AdtagInitializer *adtagInitializer;
}

@synthesize hashValue;

- (void)viewDidLoad {
    [super viewDidLoad];
    beaconManager = [AdtagBeaconManager shared];
    adtagInitializer = [AdtagInitializer shared];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void) viewDidAppear:(BOOL)animated{
    // Register Range Delegate protocol to your view
    [beaconManager registerInProximityInForeground:self];
    [adtagInitializer registerProximityErrorDelegate:self];
    [super viewDidAppear:animated];
}

- (void) viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [beaconManager unregisterInProximityInForeground:self];
    [adtagInitializer unregisterProximityErrorDelegate:self];
    //[beaconManager registerAdtagRangeDelegate:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) onProximityErrorWithErrorType:(NSInteger)errorType message:(NSString *)message {
    _txt_nbrBeacon.text =[NSString stringWithFormat:NSLocalizedString(@"error", @""), errorType, message];
}

-(void) proximityContentsInForegroundWithContents:(NSArray<id<PlaceInAppAction>> *)contents {
    _txt_nbrBeacon.text =[NSString stringWithFormat:NSLocalizedString(@"beaconAround", @""), contents.count];
}



@end

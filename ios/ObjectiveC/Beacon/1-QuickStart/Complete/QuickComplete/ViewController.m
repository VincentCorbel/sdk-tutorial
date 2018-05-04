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
    AdtagPlaceDetectionManager *placeDetectionManager;
    AdtagInitializer *adtagInitializer;
}

@synthesize hashValue;

- (void)viewDidLoad {
    [super viewDidLoad];
    placeDetectionManager = [AdtagPlaceDetectionManager shared];
    adtagInitializer = [AdtagInitializer shared];

    // Do any additional setup after loading the view, typically from a nib.
}

- (void) viewWillAppear:(BOOL)animated{
    // Register Range Delegate protocol to your view
    [placeDetectionManager registerInProximityInForeground:self];
    [adtagInitializer registerProximityHealthCheckDelegate:self];
    [super viewWillAppear:animated];
}

- (void) viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [placeDetectionManager unregisterInProximityInForeground:self];
    [adtagInitializer unregisterProximityHealthCheckDelegate:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void) onProximityHealthCheckUpdate:(HealthStatus *)healthStatus {
    NSMutableString *error = [[NSMutableString alloc] initWithString:@""];
    if ([healthStatus isDown]) {
        for (ServiceStatus *serviceStatus in [healthStatus.serviceStatusMap allValues]) {
            if ([serviceStatus isDown]) {
                for (Status *status in serviceStatus.statusList) {
                    [error appendString:status.message];
                    [error appendString:@"\n"];
                }
            }
        }
    }
    _txt_nbrBeacon.text = error;
}

-(void) proximityContentsInForeground:(NSArray<AdtagPlaceInAppAction *> *)contents {
    _txt_nbrBeacon.text =[NSString stringWithFormat:NSLocalizedString(@"beaconAround", @""), contents.count];
}



@end

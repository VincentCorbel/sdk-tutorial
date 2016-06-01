//
//  ViewController.m
//  Authorization
//
//  Created by sarra srairi on 22/03/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //register the protocol for did range beacon
    [[ATBeaconManager sharedInstance] registerAdtagBeaconBleLocationDelegate:self];

}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[ATBeaconManager sharedInstance] registerAdtagBeaconBleLocationDelegate:nil];

}

-(void)checkBleStatus:(CBCentralManagerState)bleStatus
       locationStatus:(CLAuthorizationStatus)locationStatus{
    
    if(locationStatus==kCLAuthorizationStatusDenied || locationStatus == kCLAuthorizationStatusRestricted){
        _labelStatus.text = NSLocalizedString(@"adtag.warning.Location.status.text", nil);
    }else if (bleStatus== CBCentralManagerStateUnauthorized || bleStatus == CBCentralManagerStatePoweredOff){
        _labelStatus.text = NSLocalizedString(@"adtag.warning.ble.status.text", nil);
    }else if(bleStatus == CBCentralManagerStateUnsupported){
        _labelStatus.text = NSLocalizedString(@"adtag.notsupported.ble.status.text", nil);
    }else{
         _labelStatus.text = NSLocalizedString(@"adtag.ready", nil);
    }
  
    [_labelStatus setNeedsDisplay];
}

@end

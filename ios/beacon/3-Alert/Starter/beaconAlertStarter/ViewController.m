//
//  ViewController.m
//  beaconAlertStart
//
//  Created by sarra srairi on 29/03/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import "ViewController.h"
#import "AlertViewControllerAction.h"
@interface ViewController () {
    bool isBeaconActionInProgress;
    ATBeaconContent *currentAlertBeaconContent;
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    isBeaconActionInProgress = false;
  
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //register the protocol for did range beacon
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    //unregister the protocol
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"alert"]) {
        AlertViewControllerAction *controllerAlert= (AlertViewControllerAction *)[segue destinationViewController];
        controllerAlert.alertBeaconContent = currentAlertBeaconContent;
    }
}
@end

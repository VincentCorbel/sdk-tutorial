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
    AdtagPlaceInAppAction *currentPlaceInAppAction;
}

@end

@implementation ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
 }

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    AlertViewControllerAction *alertViewController = (AlertViewControllerAction *) segue.destinationViewController;
    alertViewController.currentPlaceInAppAction = currentPlaceInAppAction;
}

@end

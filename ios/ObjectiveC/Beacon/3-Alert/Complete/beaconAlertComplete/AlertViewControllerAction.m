//
//  AlertViewControllerAction.m
//  beaconAlertComplete
//
//  Created by sarra srairi on 08/04/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import "AlertViewControllerAction.h"

@interface AlertViewControllerAction (){
 
}

@end

@implementation AlertViewControllerAction

@synthesize currentPlaceInAppAction;

- (void)viewDidLoad {
    [super viewDidLoad];
    self.txtdescription.text = [currentPlaceInAppAction getDescription];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

@end

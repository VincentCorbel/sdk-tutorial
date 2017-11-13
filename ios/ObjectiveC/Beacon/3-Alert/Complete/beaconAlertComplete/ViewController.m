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
    [[AdtagBeaconManager shared] registerInAppActionDelegate:self];
 
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[AdtagBeaconManager shared] unregisterInAppActionDelegate];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (BOOL)createInAppAction:(AdtagPlaceInAppAction * _Nonnull)placeInAppAction statusManager:(id<InAppActionStatusManagerDelegate> _Nonnull)statusManager {
    if([@"popup" isEqualToString:[placeInAppAction getAction]]){
        // create a popup view
        NSLog(@"Well done! now you can create your Pop UP");
        _txtAlertMessage.text = [placeInAppAction getTitle];
        [_txtAlertMessage setNeedsDisplay];
        _buttonAlert.hidden=false;
        currentPlaceInAppAction = placeInAppAction;
        return YES ;
    }
    
    _txtAlertMessage.text = @"No Beacons ready for action";
    [_txtAlertMessage setNeedsDisplay];
    return NO ;
}

- (BOOL)removeInAppAction:(AdtagPlaceInAppAction * _Nonnull)placeInAppAction inAppActionRemoveStatus:(enum InAppActionRemoveStatus)inAppActionRemoveStatus {
    _buttonAlert.hidden= true;
    _txtAlertMessage.text = @"Remove beacon alert action";
    [_txtAlertMessage setNeedsDisplay];
    return YES;
}

@end

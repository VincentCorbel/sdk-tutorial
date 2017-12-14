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
    [[AdtagBeaconManager shared] registerInProximityInForeground:self];
 
}
-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [[AdtagBeaconManager shared] unregisterInAppActionDelegate];
    [[AdtagBeaconManager shared] unregisterInProximityInForeground:self];
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
    _txtAlertMessage.text = @"The In-App Action has been removed";
    [_txtAlertMessage setNeedsDisplay];
    return YES;
}

- (void) proximityContentsInForeground:(NSArray<AdtagPlaceInAppAction *> *)contents {
    for (AdtagPlaceInAppAction *place in contents) {
        NSLog(@"place: %@", place);
    }
}

- (void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    AlertViewControllerAction *alertViewController = (AlertViewControllerAction *) segue.destinationViewController;
    alertViewController.currentPlaceInAppAction = currentPlaceInAppAction;
}

@end

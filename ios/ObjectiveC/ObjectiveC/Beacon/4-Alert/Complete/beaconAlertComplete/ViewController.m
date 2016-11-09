//
//  ViewController.m
//  beaconAlertStart
//
//  Created by sarra srairi on 29/03/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import "ViewController.h"
#import "AlertViewControllerAction.h"
#import "FirstWayAlertTimerStrategy.h"
@interface ViewController () {
 
    ATBeaconContent *currentAlertBeaconContent;
}

@end

@implementation ViewController

-(void)viewDidLoad {
    [super viewDidLoad];
 
    // Do any additional setup after loading the view, typically from a nib.
}

-(void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    //register the protocol for did range beacon
    [[ATBeaconManager sharedInstance] registerBeaconAlertDelgate:self];
 
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[ATBeaconManager sharedInstance] registerBeaconAlertDelgate:nil];
}

-(void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//comment Alert delegate method
-(BOOL)createBeaconAlert:(ATBeaconContent *)_beaconContent{
   
    if([@"popup" isEqualToString:[_beaconContent getAction]]){
        // create a popup view
        NSLog(@"Well done! now you can create your Pop UP");
        _txtAlertMessage.text = [_beaconContent getAlertTitle];
        [_txtAlertMessage setNeedsDisplay];
        _buttonAlert.hidden=false;
        currentAlertBeaconContent = _beaconContent;
        return YES ;
    }
    
    _txtAlertMessage.text = @"No Beacons ready for action";
    [_txtAlertMessage setNeedsDisplay];
    return NO ;
}
 
-(BOOL)removeBeaconAlert:(ATBeaconContent *)_beaconContent actionStatus:(ATBeaconRemoveStatus)_actionStatus{
    _buttonAlert.hidden= true;
    _txtAlertMessage.text = @"Remove beacon alert action";
    [_txtAlertMessage setNeedsDisplay];
    return YES;
}

-(void)onNetworkError:(ATRangeFeedStatus)_feedStatus{
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"alert"]) {
        AlertViewControllerAction *controllerAlert= (AlertViewControllerAction *)[segue destinationViewController];
        controllerAlert.alertBeaconContent = currentAlertBeaconContent;
    }
}

@end

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
    [[ATBeaconManager sharedInstance] registerAdtagRangeDelegate:self];
}
-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [[ATBeaconManager sharedInstance] registerAdtagRangeDelegate:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)didRangeBeacons:(NSArray *)_beacons beaconContents:(NSArray *)_beaconContents informationStatus:(ATRangeInformationStatus)informationStatus feedStatus:(ATRangeFeedStatus)feedstatus region:(CLRegion *)region{
    if(_beaconContents.count==0){
        isBeaconActionInProgress = false;
        _txtAlertMessage.text = @"Waiting for beacons";
        [_txtAlertMessage setNeedsDisplay];
        _buttonAlert.hidden=true;
    }else if(informationStatus == ATRangeInformationStatusComplete && !isBeaconActionInProgress){
        for(int i=0; i<_beaconContents.count; i++){
            ATBeaconContent *alertBeaconContent = [_beaconContents objectAtIndex:i];
            if ([alertBeaconContent isReadyForAction]){
                if([@"popup" isEqualToString:[alertBeaconContent getAction]]){
                    // create a popup view
                    NSLog(@"Well done! now you can create your Pop UP");
                    _txtAlertMessage.text = [alertBeaconContent getAlertTitle];
                    [_txtAlertMessage setNeedsDisplay];
                    _buttonAlert.hidden=false;
                    [alertBeaconContent actionIsDone];
                    isBeaconActionInProgress=true;
                    currentAlertBeaconContent = alertBeaconContent;
                    return;
                }
            }
        }
        _txtAlertMessage.text = @"No Beacons ready for action";
        [_txtAlertMessage setNeedsDisplay];
    }
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"alert"]) {
        AlertViewControllerAction *controllerAlert= (AlertViewControllerAction *)[segue destinationViewController];
        controllerAlert.alertBeaconContent = currentAlertBeaconContent;
    }
}
@end

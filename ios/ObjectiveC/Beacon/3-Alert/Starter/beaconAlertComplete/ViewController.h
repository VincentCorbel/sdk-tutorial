//
//  ViewController.h
//  beaconAlertStart
//
//  Created by sarra srairi on 29/03/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//
#import <UIKit/UIKit.h>
@import ConnectPlaceActions;
@import AdtagConnection;
@import AdtagLocationBeacon;

@interface ViewController : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *buttonAlert;
@property (weak, nonatomic) IBOutlet UILabel *txtAlertMessage;

@end

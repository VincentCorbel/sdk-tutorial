//
//  AlertViewControllerAction.h
//  beaconAlertComplete
//
//  Created by sarra srairi on 08/04/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//
#import <UIKit/UIKit.h>
@import AdtagConnection;
@import AdtagLocationBeacon;

@interface AlertViewControllerAction : UIViewController

@property (strong, nonatomic) AdtagPlaceInAppAction *currentPlaceInAppAction;
@property (weak, nonatomic) IBOutlet UILabel *txtdescription;

@end

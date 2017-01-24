//
//  AlertViewControllerAction.h
//  beaconAlertComplete
//
//  Created by sarra srairi on 08/04/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//
#import <ATLocationBeacon/ATLocationBeacon.h>
#import <ATConnectionHttp/ATConnectionHttp.h>
#import <UIKit/UIKit.h>

@interface AlertViewControllerAction : UIViewController
@property (strong, nonatomic)  ATBeaconContent *alertBeaconContent;
@property (weak, nonatomic) IBOutlet UILabel *txtdescription;

//-(void) load:(ATBeaconContent *)_beaconContent redirectType:(ATBeaconRedirectType)_redirectType from:(NSString *)_from;
@end

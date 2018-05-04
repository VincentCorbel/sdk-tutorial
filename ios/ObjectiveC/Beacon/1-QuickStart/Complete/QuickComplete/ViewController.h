//
//  ViewController.h
//  QuickStart
//
//  Created by sarra srairi on 22/03/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import <UIKit/UIKit.h>
@import AdtagLocationDetection;
@import AdtagConnection;
@import ConnectPlaceCommon;

@interface ViewController : UIViewController <AdtagInProximityInForegroundDelegate, ProximityHealthCheckDelegate> {

}

@property (weak, nonatomic) IBOutlet UILabel *txt_nbrBeacon;
@end


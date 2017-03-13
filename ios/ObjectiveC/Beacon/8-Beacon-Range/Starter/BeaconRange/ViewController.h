//
//  ViewController.h
//  QuickStart
//
//  Created by sarra srairi on 22/03/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ATLocationBeacon/ATLocationBeacon.h>
#import <ATConnectionHttp/ATConnectionHttp.h>
@interface ViewController : UIViewController  {
    ATBeaconManager *beaconManager;
}

@property (weak, nonatomic) IBOutlet UILabel *txt_nbrBeacon;


@end


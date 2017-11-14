//
//  ViewController.h
//  QrNfcV3Obj
//
//  Created by Connecthings on 02/10/2017.
//  Copyright © 2017 Connecthings. All rights reserved.
//

#import <UIKit/UIKit.h>
@import AdtagConnection;
@import ConnectPlaceCommon;

@interface ViewController : UIViewController <AdtagScanProximityDelegate, ProximityErrorDelegate>


@end


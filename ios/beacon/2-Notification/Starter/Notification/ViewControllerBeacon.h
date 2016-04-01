//
//  ViewController.h
//  Notification
//
//  Created by sarra srairi on 22/03/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ATLocationBeacon/ATLocationBeacon.h>
#import <ATConnectionHttp/ATConnectionHttp.h>
@interface ViewControllerBeacon : UIViewController{
    NSString *messageString;
}

@property (nonatomic, assign) IBOutlet UILabel *txtMessage;
@property (retain, nonatomic) NSString *messageString;


-(void) load:(ATBeaconContent *)_beaconContent redirectType:(ATBeaconRedirectType)_redirectType from:(NSString *)_from;
@end


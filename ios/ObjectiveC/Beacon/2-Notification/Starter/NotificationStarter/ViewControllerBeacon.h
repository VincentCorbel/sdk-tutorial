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
@interface ViewControllerBeacon : UIViewController<ATBeaconReceiveNotificatonContentDelegate>{

}

@property (nonatomic, assign) IBOutlet UILabel *txtMessage;

@end


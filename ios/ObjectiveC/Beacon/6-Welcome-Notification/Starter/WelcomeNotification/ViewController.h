//
//  ViewController.h
//  WelcomeNotification
//
//  Created by sarra srairi on 20/12/2016.
//  Copyright © 2016 com.connecthings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <ATLocationBeacon/ATLocationBeacon.h>
@interface ViewController : UIViewController <ATBeaconReceiveNotificatonContentDelegate>

@property (nonatomic, assign) IBOutlet UILabel *txtMessage;

@end


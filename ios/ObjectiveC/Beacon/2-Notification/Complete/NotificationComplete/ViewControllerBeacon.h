//
//  ViewController.h
//  Notification
//
//  Created by sarra srairi on 22/03/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import <UIKit/UIKit.h>
@import ConnectPlaceActions;
@import AdtagLocationBeacon;
@import AdtagConnection;

@interface ViewControllerBeacon : UIViewController <AdtagReceiveNotificationContentDelegate> {
}

@property (nonatomic, assign) IBOutlet UILabel *txtMessage;
 
@end


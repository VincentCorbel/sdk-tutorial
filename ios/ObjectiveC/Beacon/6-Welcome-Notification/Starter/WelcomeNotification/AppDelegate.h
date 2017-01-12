//
//  AppDelegate.h
//  WelcomeNotification
//
//  Created by sarra srairi on 20/12/2016.
//  Copyright © 2016 com.connecthings. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>
#import <ATLocationBeacon/ATLocationBeacon.h>
#import <ATConnectionHttp/ATConnectionHttp.h>
#import <AVFoundation/AVFoundation.h>


@interface AppDelegate : ATBeaconAppDelegate <UIApplicationDelegate,ATBeaconNotificationDelegate>{

}
    
@property (strong, nonatomic) UIWindow *window;


@end


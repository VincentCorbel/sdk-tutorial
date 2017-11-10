//
//  AppDelegate.h
//  QuickStart
//
//  Created by sarra srairi on 22/03/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import <UIKit/UIKit.h>
@import UserNotifications;
@import AdtagConnection;

@interface AppDelegate : UIResponder <UIApplicationDelegate, AdtagReceiveNotificationContentDelegate>

@property (strong, nonatomic) UIWindow *window;


@end


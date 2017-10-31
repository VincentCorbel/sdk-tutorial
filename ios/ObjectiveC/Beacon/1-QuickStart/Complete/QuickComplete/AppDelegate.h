//
//  AppDelegate.h
//  QuickStart
//
//  Created by sarra srairi on 22/03/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

#import <UIKit/UIKit.h>
@import UserNotifications;
@import ConnectPlaceActions;


@interface AppDelegate : UIResponder <UIApplicationDelegate, UNUserNotificationCenterDelegate, ReceiveNotificatonContentDelegate>

@property (strong, nonatomic) UIWindow *window;


@end


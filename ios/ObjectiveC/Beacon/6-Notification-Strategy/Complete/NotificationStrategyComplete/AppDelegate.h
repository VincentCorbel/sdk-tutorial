//
//  AppDelegate.h
//  Notification
//
//

#import <UIKit/UIKit.h>
#import <ATLocationBeacon/ATLocationBeacon.h>
#import <ATConnectionHttp/ATConnectionHttp.h>

@interface AppDelegate : ATBeaconAppDelegate <UIApplicationDelegate,ATBeaconReceiveNotificatonContentDelegate>


@property (strong, nonatomic) UIWindow *window;


@end


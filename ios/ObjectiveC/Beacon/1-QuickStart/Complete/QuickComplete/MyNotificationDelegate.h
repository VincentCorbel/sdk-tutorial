//
//  MyNotificationDelegate.h
//  QuickComplete
//
//  Created by Connecthings on 09/11/2017.
//  Copyright © 2017 R&DConnecthings. All rights reserved.
//

#import <Foundation/Foundation.h>
@import UserNotifications;
@import AdtagLocationDetection;

@interface MyNotificationDelegate : NSObject <UNUserNotificationCenterDelegate>

-(id) initWithDetectionManager: (AdtagPlaceDetectionManager *) _adtagPlaceDetectionManager;

@end

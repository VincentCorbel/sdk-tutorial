//
//  MyNotificationDelegate.m
//  QuickComplete
//
//  Created by Connecthings on 09/11/2017.
//  Copyright © 2017 R&D Connecthings. All rights reserved.
//

#import "MyNotificationDelegate.h"

@implementation MyNotificationDelegate {
    AdtagPlaceDetectionManager *adtagPlaceDetectionManager;
}

-(id) initWithDetectionManager: (AdtagPlaceDetectionManager *) _adtagPlaceDetectionManager {
    self = [super init];
    if (self) {
        adtagPlaceDetectionManager = _adtagPlaceDetectionManager;
    }
    return self;
}

-(void) userNotificationCenter:(UNUserNotificationCenter *)center didReceiveNotificationResponse:(UNNotificationResponse *)response withCompletionHandler:(void (^)(void))completionHandler {
    [adtagPlaceDetectionManager didReceivePlaceNotification:response.notification.request.content.userInfo];
}

@end

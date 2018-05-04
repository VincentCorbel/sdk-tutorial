//
//  Optin.m
//  QuickComplete
//
//  Created by Connecthings on 04/05/2018.
//  Copyright © 2018 sarra srairi. All rights reserved.
//

#import "Optin.h"
@import AdtagConnection;

@implementation Optin : NSObject

    - (void) manage {
        AdtagInitializer *adtagInitializer = [AdtagInitializer shared];
         //To know if an optin has been updated
        if ([adtagInitializer areOptinsUpdateOnce]) {
            // No update, ask the optin ?
        }
        //Update the optin status even if it's false
        [adtagInitializer updateOptinWithOptin:OptinLOCATION permission:true];
        [adtagInitializer updateOptinWithOptin:OptinUSER_ID permission:false];
        //get the optin status
        [adtagInitializer isOptinAuthorizedWithOptin:OptinLOCATION];
    }

@end



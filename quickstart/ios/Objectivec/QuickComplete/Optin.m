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
         //To know if the opt-in has been asked
        if ([adtagInitializer optinsNeverAsked]) {
            // No update, ask the optin ?
        }
        //get the optin status
        [adtagInitializer isOptinAuthorizedWithOptin:OptinUSER_DATA];
        //Update the optin status even if it's false
        [adtagInitializer updateOptin:OptinUSER_DATA permission:true];
        // Notify the SDK that you have finished with the opti-ns update - call it each time the opt-ins are udpated
        [adtagInitializer allOptinsAreUpdated];
    }

@end



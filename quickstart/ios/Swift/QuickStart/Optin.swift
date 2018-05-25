//
//  Optin.swift
//  QuickStart
//
//  Created by Connecthings on 04/05/2018.
//  Copyright © 2018 R&D connecthings. All rights reserved.
//

import Foundation
import AdtagConnection

class Optin {

    static func manage() {
        let adtagInitializer = AdtagInitializer.shared
        //To know if an optin has been updated
        if adtagInitializer.optinsNeverAsked() {
            // No update, ask the optin ?
        }

        //get the optin status
        adtagInitializer.isOptinAuthorized(optin: .USER_DATA)
        //Update the optin status even if it's false
        adtagInitializer.updateOptin(.USER_DATA, permission: true)
        // Notify the SDK that you have finished with the opti-ns update - call it each time the opt-ins are udpated
        adtagInitializer.allOptinsAreUpdated()
    }

}

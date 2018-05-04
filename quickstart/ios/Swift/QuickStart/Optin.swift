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
        if adtagInitializer.areOptinsUpdateOnce() {
            // No update, ask the optin ?
        }
        //Update the optin status even if it's false
        adtagInitializer.updateOptin(optin: .LOCATION, permission: true)
        adtagInitializer.updateOptin(optin: .STATUS, permission: false)
        //get the optin status
        adtagInitializer.isOptinAuthorized(optin: .LOCATION)
    }

}

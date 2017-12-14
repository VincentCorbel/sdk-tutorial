//
//  AppDelegate.swift
//  AlertStrategy
//
//  Created by sarra srairi on 11/08/2016.
//  Copyright © 2016 R&D connecthings. All rights reserved.
//

import UIKit
import AdtagAnalytics
import AdtagConnection
import AdtagLocationBeacon
import AVFoundation

@UIApplicationMain

class AppDelegate: NSObject, UIApplicationDelegate {
    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        AdtagInitializer.shared.configPlatform(Platform.preProd)
                               .configUser(login: "__LOGIN__", password: "__PSWD__", company: "__COMPANY__")
                               .synchronize()
        return true
    }
    
    
    func applicationWillResignActive(_ application: UIApplication) {
        AdtagInitializer.shared.onAppInBackground()
    }
    
    func applicationDidBecomeActive(_ application: UIApplication) {
        AdtagInitializer.shared.onAppInForeground()
    }
}

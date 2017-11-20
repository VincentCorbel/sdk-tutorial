//
//  ViewController.swift
//  Complete
//
//  Created by Stevens Olivier on 26/01/2017.
//  Copyright © 2017 R&D connecthings. All rights reserved.
//

import UIKit
import UserNotifications
import ConnectPlaceActions
import AdtagConnection
import AdtagLocationBeacon

class ViewController: UIViewController, AdtagReceiveNotificationContentDelegate, AdtagInProximityInForegroundDelegate {
    @IBOutlet weak var labelBeacon: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                if error == nil {
                    NSLog("request authorization succeeded!");
                }
            }
        }
        
        AdtagBeaconManager.shared.registerReceiveNotificatonContentDelegate(self)
    }
    
    func proximityContentsInForeground(contents: [AdtagPlaceInAppAction]) {
        for placeInAppAction in contents {
            print("placeInAppAction: \(placeInAppAction)")
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AdtagBeaconManager.shared.registerInProximityInForeground(self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        AdtagBeaconManager.shared.unregisterInProximityInForeground(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    func didReceivePlaceNotification(_ placeNotification: AdtagPlaceNotification) {
        displayRemoteNotification(placeNotification)
    }

    func didReceiveWelcomeNotification(_ welcomeNotification: AdtagPlaceWelcomeNotification) {
        displayRemoteNotification(welcomeNotification)
    }

    private func displayRemoteNotification(_ placeNotification: PlaceNotification) {
        self.labelBeacon.text = placeNotification.getTitle()
        self.labelBeacon.setNeedsDisplay()
    }
}

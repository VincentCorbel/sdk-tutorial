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
import AdtagLocationBeacon

class ViewController: UIViewController, ReceiveNotificatonContentDelegate {
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

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func didReceivePlaceNotification(placeNotification: PlaceNotification) {
        displayRemoteNotification(placeNotification)
    }
    
    func didReceiveWelcomeNotification(welcomeNotification: PlaceWelcomeNotification) {
        displayRemoteNotification(welcomeNotification)
    }
    
    private func displayRemoteNotification(_ placeNotification: PlaceNotification) {
        self.labelBeacon.text = placeNotification.getTitle()
        self.labelBeacon.setNeedsDisplay()
    }
}

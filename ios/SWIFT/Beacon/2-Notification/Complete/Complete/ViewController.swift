//
//  ViewController.swift
//  Complete
//
//  Created by Stevens Olivier on 26/01/2017.
//  Copyright © 2017 R&D connecthings. All rights reserved.
//

import UIKit
import ATLocationBeacon
import UserNotifications

class ViewController: UIViewController {

    @IBOutlet weak var labelBeacon: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if #available(iOS 10.0, *) {
            let center = UNUserNotificationCenter.current()
            center.requestAuthorization(options: [.alert, .sound]) { (granted, error) in
                // Enable or disable features based on authorization.
                if error == nil {
                    NSLog("request authorization succeeded!");
                }
            }
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(remoteNotificationReceived), name: NSNotification.Name("beaconNotification"), object: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func remoteNotificationReceived(notification:NSNotification!) {
        let beaconContent:ATBeaconContent! = notification.userInfo?["beaconContent"] as! ATBeaconContent;
        self.labelBeacon.text = beaconContent.getNotificationTitle()
        self.labelBeacon.setNeedsDisplay()
    }
}


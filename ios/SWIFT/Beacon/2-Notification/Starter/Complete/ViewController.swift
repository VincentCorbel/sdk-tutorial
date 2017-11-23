//
//  ViewController.swift
//  Complete
//
//  Created by Connecthings on 26/01/2017.
//  Copyright © 2017 R&D connecthings. All rights reserved.
//

import UIKit
import ConnectPlaceActions
import AdtagConnection
import AdtagLocationBeacon

class ViewController: UIViewController {
    @IBOutlet weak var labelBeacon: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(remoteNotificationReceived), name: NSNotification.Name("placeNotification"), object: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @objc func remoteNotificationReceived(notification:NSNotification!) {
        if let placeNotification: PlaceNotification = notification.userInfo!["placeNotification"] as? PlaceNotification {
            self.labelBeacon.text = placeNotification.getTitle()
            self.labelBeacon.setNeedsDisplay()
        }
    }
}

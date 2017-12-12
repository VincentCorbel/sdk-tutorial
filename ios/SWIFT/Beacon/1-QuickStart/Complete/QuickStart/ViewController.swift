//
//  ViewController.swift
//  QuickStart
//
//  Created by sarra srairi on 10/08/2016.
//  Copyright © 2016 R&D connecthings. All rights reserved.
//
import UIKit
import AdtagConnection
import ConnectPlaceActions;
import AdtagLocationBeacon;
import ConnectPlaceCommon;

class ViewController: UIViewController, AdtagInProximityInForegroundDelegate, ProximityHealthCheckDelegate {
    @IBOutlet weak var txt_message: UILabel!
    var adtagInitializer: AdtagInitializer?
    var adtagBeaconManager: AdtagBeaconManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        adtagInitializer = AdtagInitializer.shared
        adtagBeaconManager = AdtagBeaconManager.shared
    }

    override func viewWillAppear(_ animated: Bool) {
        adtagInitializer?.registerProximityHealthCheckDelegate(self)
        adtagBeaconManager?.registerInProximityInForeground(self)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        adtagInitializer?.unregisterProximityHealthCheckDelegate(self)
        adtagBeaconManager?.unregisterInProximityInForeground(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func proximityContentsInForeground(_ contents: [AdtagPlaceInAppAction]) {
        self.txt_message.text = String( format: NSLocalizedString("beaconAround", comment:""), contents.count)
    }

    func onProximityHealthCheckUpdate(_ healthStatus: HealthStatus) {
        var error: String = ""
        if healthStatus.isDown {
            for serviceStatus in healthStatus.serviceStatusMap.values {
                if serviceStatus.isDown() {
                    for status in serviceStatus.statusList {
                        error += status.message + "\n"
                    }
                }
            }
        }

        self.txt_message.text = error
    }
 
}

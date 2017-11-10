//
//  ViewController.swift
//  QuickStart
//
//  Created by sarra srairi on 10/08/2016.
//  Copyright © 2016 R&D connecthings. All rights reserved.
//
import UIKit
import AdtagConnection
import ConnectPlaceActions
import AdtagLocationBeacon
import ConnectPlaceCommon

class ViewController: UIViewController, AdtagInProximityInForegroundDelegate, ProximityErrorDelegate {
    
    @IBOutlet weak var txt_message: UILabel!
    var adtagInitializer: AdtagInitializer?
    var adtagBeaconManager: AdtagBeaconManager?

    override func viewDidLoad() {
        super.viewDidLoad()
        adtagInitializer = AdtagInitializer.shared
        adtagBeaconManager = AdtagBeaconManager.shared
        // Do any additional setup after loading the view, typically from a nib

    }

    override func viewWillAppear(_ animated: Bool) {
        adtagInitializer?.registerProximityErrorDelegate(self)
        adtagBeaconManager?.registerInProximityInForeground(self)
        super.viewWillAppear(animated)
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        adtagInitializer?.unregisterProximityErrorDelegate(self)
        adtagBeaconManager?.unregisterInProximityInForeground(self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func proximityContentsInForeground(contents: [AdtagPlaceInAppAction]) {
        self.txt_message.text = String( format: NSLocalizedString("beaconAround", comment:""), contents.count)
    }

    func onProximityError(errorType: Int, message: NSString) {
        self.txt_message.text = String( format: NSLocalizedString("error", comment:""), errorType, message)
    }
 
}

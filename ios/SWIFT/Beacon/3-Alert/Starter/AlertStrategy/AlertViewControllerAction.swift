//
//  AlertViewControllerAction.swift
//  AlertStrategy
//
//  Created by Ludovic Vimont on 20/11/2017.
//  Copyright © 2017 R&D connecthings. All rights reserved.
//

import Foundation
import UIKit
import AdtagConnection
import AdtagLocationBeacon

public class AlertViewControllerAction: UIViewController {
    @IBOutlet weak var textDescription: UILabel!
    var currentPlaceInAppAction: AdtagPlaceInAppAction!
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        textDescription.text = currentPlaceInAppAction.getDescription()
        AdtagBeaconManager.shared.redirect(placeInAppAction: currentPlaceInAppAction, from: "AlertViewControllerAction")
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

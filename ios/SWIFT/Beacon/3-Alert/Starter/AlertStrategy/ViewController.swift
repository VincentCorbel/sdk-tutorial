//
//  ViewController.swift
//  AlertStrategy
//
//  Created by sarra srairi on 11/08/2016.
//  Copyright © 2016 R&D connecthings. All rights reserved.
//

import UIKit
import ATAnalytics
import ATLocationBeacon

class ViewController: UIViewController {
    
    @IBOutlet weak var txtAlertMessage: UILabel!
 
    @IBOutlet weak var actionTxt: UILabel!
    var currentAlertBeaconContent: ATBeaconContent!
  
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated);
   
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidAppear(animated);
    }
 
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
 
}


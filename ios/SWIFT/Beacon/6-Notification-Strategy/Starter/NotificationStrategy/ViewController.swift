//
//  ViewController.swift
//  NotificationStrategy
//
//  Created by sarra srairi on 11/08/2016.
//  Copyright © 2016 R&D connecthings. All rights reserved.
//
import UIKit
import ATConnectionHttp
import ATAnalytics
import ATLocationBeacon
class ViewController: UIViewController,ATBeaconReceiveNotificatonContentDelegate {
    
    @IBOutlet weak var txtMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
      ATBeaconManager.sharedInstance().registerNotificationContentDelegate(self);
        // Do any additional setup after loading the view, typically from a nib
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    func didReceiveNotificationContentReceived(_ _beaconContent: ATBeaconContent!) {
        self.txtMessage.text = _beaconContent.getNotificationTitle()
        self.txtMessage.setNeedsDisplay()
    }
    
    func didReceiveWelcomeNotificationContentReceived(_ _welcomeNotificationContent: ATBeaconWelcomeNotification!) {
        
    }
}

//
//  ViewController.swift
//  SimpleNotification
//
//  Created by sarra srairi on 10/08/2016.
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
              NotificationCenter.default.addObserver(self, selector: #selector(self.remoteNotificationReceived), name: NSNotification.Name(rawValue: "LocalNotificationMessageReceivedNotification"), object: nil)

        // Do any additional setup after loading the view, typically from a nib
 
     }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

  
    
    func remoteNotificationReceived(notification: NSNotification) {
        let beaconContent: ATBeaconContent = (notification.userInfo!["beaconContent"] as! ATBeaconContent)
        self.txtMessage.text = beaconContent.getNotificationTitle()
        self.txtMessage.setNeedsDisplay()
    }
}

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
class ViewController: UIViewController {
    
    @IBOutlet weak var labelNotification: UILabel!
    @IBOutlet weak var txtMessage: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(self.remoteNotificationReceived), name: "LocalNotificationMessageReceivedNotification", object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func remoteNotificationReceived(notification: NSNotification) {
        if (notification.userInfo!["beaconContent"]  == nil){
            
          
          let  welcomeNotification: ATBeaconWelcomeNotification = (notification.userInfo!["beaconWelcomeNotification"] as! ATBeaconWelcomeNotification)
            
            self.labelNotification.text = "Congratulations! You generate your first beacon welcome notification"
            ATBeaconManager.sharedInstance().sendRedictLog(welcomeNotification, from: "notification")

        }else {
            let beaconContent: ATBeaconContent = (notification.userInfo!["beaconContent"] as! ATBeaconContent)
            self.txtMessage.text = beaconContent.getNotificationTitle()
            self.txtMessage.setNeedsDisplay()
        }
    }
    
}
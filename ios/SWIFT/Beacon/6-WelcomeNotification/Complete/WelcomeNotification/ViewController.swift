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
        NotificationCenter.default.addObserver(self, selector: #selector(self.remoteNotificationReceived), name: NSNotification.Name(rawValue: "LocalNotificationMessageReceivedNotification"), object: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func remoteNotificationReceived(_ notification: Notification) {
        if ((notification as NSNotification).userInfo!["beaconContent"]  == nil){
            
            
            let  welcomeNotification: ATBeaconWelcomeNotification = ((notification as NSNotification).userInfo!["beaconWelcomeNotification"] as! ATBeaconWelcomeNotification)
            
            self.labelNotification.text = "Congratulations! You generate your first beacon welcome notification"
            ATBeaconManager.sharedInstance().sendRedictLog(welcomeNotification, from: "notification")
            
        }else {
            let beaconContent: ATBeaconContent = ((notification as NSNotification).userInfo!["beaconContent"] as! ATBeaconContent)
            self.txtMessage.text = beaconContent.getNotificationTitle()
            self.txtMessage.setNeedsDisplay()
        }
    }
    
}

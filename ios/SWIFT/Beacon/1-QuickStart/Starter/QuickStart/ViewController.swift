//
//  ViewController.swift
//  QuickStart
//
//  Created by sarra srairi on 10/08/2016.
//  Copyright © 2016 R&D connecthings. All rights reserved.
//
import UIKit
import ATConnectionHttp
import ATAnalytics
import ATLocationBeacon
class ViewController: UIViewController,ATBeaconReceiveNotificatonContentDelegate, ATRangeDelegate{
         var beaconManager: ATBeaconManager!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        beaconManager = ATBeaconManager.sharedInstance()
        beaconManager.registerAdtagRangeDelegate(self)
        beaconManager.registerNotificationContentDelegate(self);
        // Do any additional setup after loading the view, typically from a nib
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func didReceiveNotificationContentReceived(_ _beaconContent: ATBeaconContent!) {
        
        // Display the notification content :  _beaconContent.getNotificationTitle()
 
    }
    
    func didReceiveWelcomeNotificationContentReceived(_ _welcomeNotificationContent: ATBeaconWelcomeNotification!) {
        
    }
    
    
    func didRangeBeacons(_ _beacons: [Any]!, beaconContents: [Any]!, informationStatus: ATRangeInformationStatus, feedStatus: ATRangeFeedStatus, region: CLRegion!) {
        
       var feedStatusString: String
        
        switch feedStatus {
        case ATRangeFeedStatusInProgress:
            feedStatusString = "IN_PROGRESS"
        case ATRangeFeedStatusBackendError:
            feedStatusString = "BACKEND_ERROR"
        case ATRangeFeedStatusNetworkError:
            feedStatusString = "NETWORK_ERROR"
        case ATRangeFeedStatusBackendSuccess:
            feedStatusString = "BACKEND_SUCCESS"
        default:
            feedStatusString = ""
        }
 
    }
}

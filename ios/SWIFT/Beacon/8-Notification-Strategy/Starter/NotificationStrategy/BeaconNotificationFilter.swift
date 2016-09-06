//
//  BeaconNotificationFilter.swift
//  NotificationStrategy
//
//  Created by sarra srairi on 05/09/2016.
//  Copyright © 2016 R&D connecthings. All rights reserved.
//

import ATLocationBeacon
import Foundation
class BeaconNotificationFilter: NSObject, ATBeaconNotificationStrategyDelegate {
    
  
    /**
     * The filter will be defined by 2 attributes : _maxNumberNotification and _timeBetweenNotification
     * @param _maxNumberNotification : is the the maximum number of notifications
     * @param _field :the time between the next notifications stream in SECOND
     */
    convenience init( timeBetweenNotification: Int) {
        self.init()
    }
    
    func createNewNotification(newBeaconContent: ATBeaconContent, feedStatus: ATRangeFeedStatus) -> Bool {
        return true
    }
    
    func deleteCurrentNotification(newBeaconContent: ATBeaconContent, feedStatus: ATRangeFeedStatus) -> Bool {
        return true
    }
    
    func onBackground() {
    }
    
    func onForeground() {
    }
    
    func onStartMonitoringRegion(beaconContent: ATBeaconContent, feedStatus: ATRangeFeedStatus) {
    }
    
    func onNotificationIsCreated(beconContent: ATBeaconContent, notificationStatus: Bool) {
       
    }
    
    func onNotificationIsDeleted(beconContent: ATBeaconContent, notificationStatus: Bool) {
    }
 
    // this permits you to save your last data when the app is killed
    func save(dataStore: NSUserDefaults) {
    }
    // this permits to reload your data when app was killed
    func load(dataStore: NSUserDefaults) {
    }

}
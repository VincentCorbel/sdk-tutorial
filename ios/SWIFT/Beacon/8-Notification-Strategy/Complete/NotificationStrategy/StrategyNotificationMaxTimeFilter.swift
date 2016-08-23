//
//  StrategyNotificationMaxTimeFilter.swift
//  BeaconBoilerPlateTest
//
//  Created by sarra srairi on 27/05/2016.
//  Copyright © 2016 sarra srairi. All rights reserved.
//

import Foundation
import ATLocationBeacon


/**
 * Filter type based on max notification number in defined lapse time.
 * &n number of notification in &x defined lapse time.
 */

class StrategyNotificationMaxTimeFilter: NSObject, ATBeaconNotificationStrategyDelegate {
  
    var maxNumberNotifications : NSInteger!
    var timeBetweenNotification : Double!
    var notificationNumber :NSInteger!
    var nextTimeToDisplayNotification : Double!
    var isSavedToLoad : Bool!
 
    override init() {
        
    }
    
    /**
     * The filter will be defined by 2 attributes : _maxNumberNotification and _timeBetweenNotification
     * @param _maxNumberNotification : is the the maximum number of notifications
     * @param _field :the time between the next notifications stream in SECOND
     */
    convenience init(maxNumberNotification: Int, timeBetweenNotification: Int) {
        self.init()
        self.maxNumberNotifications = maxNumberNotification
        self.timeBetweenNotification = (Double(timeBetweenNotification) / 1000)
        self.validNotificationTime()
        
    }
    
    
     func createNewNotification(newBeaconContent: ATBeaconContent, feedStatus: ATRangeFeedStatus) -> Bool {
        self.validNotificationTime()
        return notificationNumber < maxNumberNotifications
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
        if notificationStatus {
            notificationNumber = notificationNumber + 1
        }
    }
    
    func onNotificationIsDeleted(beconContent: ATBeaconContent, notificationStatus: Bool) {
    }
    
    func validNotificationTime() {
        if nextTimeToDisplayNotification < CACurrentMediaTime() {
            nextTimeToDisplayNotification = CACurrentMediaTime() + timeBetweenNotification
            notificationNumber = 0
        }
    }
    // this permits you to save your last data when the app is killed
    func save(dataStore: NSUserDefaults) {
        dataStore.setInteger(notificationNumber, forKey: MAX_NUMBER_NOTIFICATION)
        dataStore.setDouble(nextTimeToDisplayNotification, forKey: TIME_BETWEEN_NOTIFICATION)
    }
      // this permits to reload your data when app was killed
    func load(dataStore: NSUserDefaults) {
        notificationNumber = dataStore.integerForKey(MAX_NUMBER_NOTIFICATION)
        nextTimeToDisplayNotification = dataStore.doubleForKey(TIME_BETWEEN_NOTIFICATION)
    }
 
}
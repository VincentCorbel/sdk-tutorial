//
//  MyNotificationFilter.swift
//  QuickStart
//
//  Created by Ludovic Vimont on 08/11/2017.
//  Copyright © 2017 R&D connecthings. All rights reserved.
//

import Foundation
import ConnectPlaceActions

public class MyNotificationFilter: NotificationFilter {
    let MIN_NEXT_TIME_NOTIFICATION = "com.notification.minNextTimeNotification"
    var minTimeBetweenNotification : Double!
    var minNextTimeNotification : Double!

    convenience init(timeBetweenNotification: Int) {
        self.init()
        self.minTimeBetweenNotification = (Double(timeBetweenNotification) / 1000)
    }
    
    public func getName() -> String {
        return "MyNotificationFilter"
    }
    
    public func createNewNotification(placeNotification: PlaceNotification) -> Bool {
        return self.minNextTimeNotification < CFAbsoluteTimeGetCurrent()
    }
    
    public func deleteCurrentNotification(placeNotification: PlaceNotification) -> Bool {
        return true
    }
    
    public func onNotificationCreated(placeNotification: PlaceNotification, created: Bool) {
        
    }
    
    public func onNotificationDeleted(placeNotification: PlaceNotification, deleted: Bool) {
        if deleted {
            minNextTimeNotification = CACurrentMediaTime() + minTimeBetweenNotification;
        }
    }
    
    public func onBackground() {
        
    }
    
    public func onForeground() {
        
    }
    
    func save(_ dataStore: UserDefaults) {
    }
    

    public func load(userDefaults: UserDefaults) {
        minNextTimeNotification = userDefaults.double(forKey: MIN_NEXT_TIME_NOTIFICATION)
    }
    
    public func save(userDefaults: UserDefaults) {
        userDefaults.set(minNextTimeNotification, forKey: MIN_NEXT_TIME_NOTIFICATION)
    }
    
    public func updateParameters(parameters: AnyObject) {
        
    }
}


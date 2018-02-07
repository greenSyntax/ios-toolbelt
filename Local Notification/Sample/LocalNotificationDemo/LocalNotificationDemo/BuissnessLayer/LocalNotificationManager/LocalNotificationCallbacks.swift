//
//  LocalNotificationCallbacks.swift
//  LocalNotificationDemo
//
//  Created by Abhishek Ravi on 07/02/18.
//

import Foundation
import UserNotifications

protocol LocalNotificationDelegate:class {
    func hasShownNotification()
}

extension LocalNotificationManager: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Swift.Void) {
        
        // When App is in Foreground
        self.delegate?.hasShownNotification()
        completionHandler([.alert, .badge, .sound])
    }
    
    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Swift.Void) {
        
        // When App is in Background
        self.delegate?.hasShownNotification()
    }
    
}


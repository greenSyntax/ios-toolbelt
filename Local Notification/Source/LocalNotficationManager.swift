/*
 The MIT License (MIT)
 Copyright (c) 2015 Abhishek Kumar Ravi
 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:
 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
 */

import Foundation
import UIKit
import CoreLocation
import UserNotifications

enum TriggerType {
    case afterSecond
    case afterInterval(TimeInterval)
    case atCoordinate(Double, Double)
    case onDate(DateComponents)
}

/// Payload Object
struct Payload {
    var title:String
    var subtitle:String
    var body:String
    var attachment: URL?
}

class LocalNotificationManager: NSObject {
    
    private var completionHanlder:((Bool, LocalNotifcationError?)->())?
    private let center = UNUserNotificationCenter.current()
    
    weak var delegate: LocalNotificationDelegate?
    
    static let shared = LocalNotificationManager()
    
    private func preprareTrigger(type:TriggerType, content: UNMutableNotificationContent) -> UNNotificationTrigger {
        
        switch type {

        // After Few Seconds
        case .afterInterval(let intervalInSeconds):
            return UNTimeIntervalNotificationTrigger(timeInterval: intervalInSeconds, repeats: false)

        // Just Now
        case .afterSecond:
            return UNTimeIntervalNotificationTrigger(timeInterval: 1.0, repeats: false)

        // Location Trigger
        case .atCoordinate(let latitude, let longitude):
            
            let coordinate = CLLocationCoordinate2D(latitude: latitude, longitude: longitude)
            let region = CLCircularRegion(center: coordinate, radius: 1000.0, identifier: "com.greensyntax.region")
            region.notifyOnExit = true
            region.notifyOnEntry = true
            return UNLocationNotificationTrigger(region: region, repeats: false)
        

        // On Date
        case .onDate(let triggerDate):
            return UNCalendarNotificationTrigger(dateMatching: triggerDate, repeats: false)
        }

    }
    
    //MARK:- Intialize LocalNotification
    private func intializeUserNotification(onCompletion:@escaping (Bool)->()){
        
        let options: UNAuthorizationOptions = [.alert, .sound]
        
        //Request for Authroization
        self.center.delegate = self
        self.center.requestAuthorization(options: options) { (granted, error) in
            
            if !granted{
                
                // onFailure
                onCompletion(false)
            }
            
            // Has Successfully Confirmed
            onCompletion(true)
        }
    }
    
    // MARK: Broadcast Notification
    func requestForLocalNotification(payload:Payload, trigger type:TriggerType,   completionHandler:@escaping (Bool, LocalNotifcationError?)->()) {
        
        // Assign
        self.completionHanlder = completionHandler
        
        // Initialize
        self.intializeUserNotification { [unowned self] (status) in
            
            if status {

                // Prepare Notification Content
                let content = UNMutableNotificationContent()
                content.title = payload.title
                content.subtitle = payload.subtitle
                content.body = payload.body
                content.badge = nil
                content.sound = UNNotificationSound.default()
                
                if let attachmentImage = payload.attachment {
                    
                    do {
                        let attachment = try UNNotificationAttachment(identifier: "com.innovationm.notification", url: payload.attachment!, options: nil)
                        content.attachments = [attachment]
                    }
                    catch {
                        // Handle Attachment Error
                    }
                }
                
                
                // Prepare Notification Request
                let request = UNNotificationRequest(identifier: "com.innovationm", content: content, trigger: self.preprareTrigger(type: type, content: content))
                
                self.center.add(request) { (error) in
                    
                    guard error == nil else {
                        if let handler = self.completionHanlder {
                            
                            // onFailure
                            handler(false, LocalNotifcationError.failed)
                        }
                        return
                    }
                    
                    // onSuccess
                    if let handler = self.completionHanlder {
                        handler(true, nil)
                    }
                }
            }
            else {
                
                if let handler = self.completionHanlder {
                    handler(false, LocalNotifcationError.permissionDenied)
                }
            }
        }
    }
    
    func cancelAllNotificationRequest() {
        
    }
    
}


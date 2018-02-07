//
//  LocalNotificationError.swift
//  LocalNotificationDemo
//
//  Created by Abhishek Ravi on 07/02/18.
//

import Foundation

extension LocalNotificationManager {
    
    /// Cutom Error
    enum LocalNotifcationError: Error{
        case permissionDenied
        case triggerCreationFailure
        case failed
        
        var errorMessage: String {
            
            switch self {
            case .permissionDenied:
                return "You App has no permission to send local notification."
             
            case .triggerCreationFailure:
                return "There is some while creating trigger object"
                
            case .failed:
                return "Failed to generate local notification"
                
            }
        }
    }
    
}

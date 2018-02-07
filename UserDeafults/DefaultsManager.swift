//
//  DefaultsManager.swift
//  LocalNotificationDemo
//
//  Created by Abhishek Ravi on 07/02/18.
//

import Foundation
import UIKit

enum KeyName: String {
    
    case associatedWithBeacon = "associatedWithBeacon"
}

class DefaultsManager {
    
    let defaults = UserDefaults.standard
    
    static let shared = DefaultsManager()
    private init(){ }
    
    /// Get Value for the Key Name
    ///
    /// - Parameter key: Name of the Name which is of type KeyName
    /// - Returns: Value of T type
    fileprivate func getObject<T>(key:String) -> T? {
        if let value = defaults.value(forKey: key), let castedValue = value as? T {
            return castedValue
        }
        return nil
    }
    
    
    /// State Object to UserDeafults Key-Value pair against their Key Name
    ///
    /// - Parameters:
    ///   - key: Key Name as String
    ///   - value: Value for the Key
    fileprivate func setObject<T>(key:String, value:T) {
        defaults.set(value, forKey: key)
    }
    
}

extension DefaultsManager {
    
    // State Value fr Beacon Association
    var hasBeenAssociatedWithBeacon: Bool {
        
        get {
            
            if let state: Bool = self.getObject(key: KeyName.associatedWithBeacon.rawValue) {
                return state
            }
            
            return false
        }
        
        set {
            setObject(key: KeyName.associatedWithBeacon.rawValue, value: newValue)
        }
    }
}

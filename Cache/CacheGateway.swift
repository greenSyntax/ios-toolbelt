//
//  CacheGateway.swift
//  admin
//
//  Created by Abhishek  Kumar Ravi on 21/09/18.
//  Copyright © 2018 C Color. All rights reserved.
//

import Foundation
import UIKit

class CacheGateway {
    
    private let instance = NSCache<NSString, AnyObject>()
    
    public static let instance = CacheGateway()
    private init(){}
    
    func set<T:AnyObject>(key: String, value: T) {
        
        if let keyName: NSString = key as? NSString {
            instance.setObject(value, forKey: keyName)
        }
    }
    
    func get<T:AnyObject>(key: String) -> T? {
        
        if let keyName: NSString = key as? NSString {
            if let cahceValue = instance.object(forKey: keyName), let val = cahceValue as? T {
                return val
            }
        }
        return nil
    }
    
}

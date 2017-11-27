//
//  LocalAuthentication.swift
//  UFOApp
//
//  Created by Abhishek Ravi on 24/11/17.
//  Copyright © 2017 InnovationM. All rights reserved.
//

import Foundation
import LocalAuthentication

enum AuthenticationError {
    
    case BiometricLockOut
    case AppCancel
    case AuthenticatonFailed
    case BiometryNotEnrolled
    case BiometryNotAvailable
    case PasscodeNotSet
    case SystemError
    case UserFallback
    case UserCancel
    case Unknown
}

class LocalAuthentication {
    
    typealias completionHandler = (_ success: Bool, _ error: AuthenticationError?)->()
    
    private static let authenticationString = "App wants to Authenticate User"
    private static let context = LAContext()
    
    static func authenticate(authenticationPromptText: String = authenticationString, handler: @escaping completionHandler) {
        
        var error: NSError?
        
        // Ask for Authentication
        if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            
            context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: authenticationPromptText, reply: { (success, error) in
                
                guard error == nil else {
                    
                    //onFailure
                    let errorType = predictError(error: error as! NSError)
                    handler(false, errorType)
                    return
                }
                
                //onSuccess Authentication
                handler(true, nil)
            })
        }
    }
    
    static func predictError(error: NSError) -> AuthenticationError  {
        
        if #available(iOS 11.0, *) {
            
            switch error.code {
                
            case LAError.authenticationFailed.rawValue:
                return AuthenticationError.AuthenticatonFailed
                
            case LAError.biometryNotEnrolled.rawValue:
                return AuthenticationError.BiometryNotEnrolled
                
            case LAError.userCancel.rawValue:
                return AuthenticationError.UserCancel
                
            case LAError.appCancel.rawValue:
                return AuthenticationError.AppCancel
                
            case LAError.biometryLockout.rawValue:
                return AuthenticationError.BiometricLockOut
                
            case LAError.biometryNotAvailable.rawValue:
                return AuthenticationError.BiometryNotAvailable
                
            case LAError.passcodeNotSet.rawValue:
                return AuthenticationError.PasscodeNotSet
                
            case LAError.systemCancel.rawValue:
                return AuthenticationError.SystemError
                
            case LAError.userFallback.rawValue:
                return AuthenticationError.UserFallback
                
            default:
                return AuthenticationError.Unknown
            }
        } else {
            // Fallback on earlier versions
        }
        
        return AuthenticationError.Unknown
    }
    
}

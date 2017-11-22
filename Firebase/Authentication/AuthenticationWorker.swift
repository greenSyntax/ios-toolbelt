//
//  AuthenticationWorker.swift
//  UFOApp
//
//  Created by Abhishek Ravi on 17/11/17.
//  Copyright © 2017 InnovationM. All rights reserved.
//

import Foundation
import FirebaseAuth

struct UserModel {
    
    var email:String
    var password: String
    
    init(email:String, password: String) {
        self.email = email
        self.password = password
    }
}

class AuthenticationWorker {
    
    typealias completionHandler = (User?, Error?)->()
    typealias onCompletion = (Bool, Error?)->()
    
    static let shared = AuthenticationWorker()
    
    let authenticationObject = Auth.auth()
    
    /// Login ith User Model where You have Email and Password
    ///
    /// - Parameters:
    ///   - user: UserModel Object
    ///   - handler: Completion Handler with User Optional Object  and Error Optional
    func login(user: UserModel, handler: @escaping completionHandler) {
        
        authenticationObject.signIn(withEmail: user.email, password: user.password) { (user, error) in
            
            guard error == nil else {
                //onError
                if let error = error {
                    handler(nil, error)
                }
                return
            }
            
            //onSuccess
            if let user = user {
             handler(user, nil)
            }
        }
    }
    
    func deleteUser(handler: @escaping onCompletion) {
        
        authenticationObject.currentUser?.delete(completion: { (error) in
            
            guard error == nil else {
                handler(false, error)
                return
            }
            
            //onSuccess
            handler(true, nil)
        })
    }
    
    /// Signup User wit UserModel Object
    ///
    /// - Parameters:
    ///   - user: UserModel Object
    ///   - handler: completionHandler Object
    func register(user: UserModel, handler: @escaping completionHandler) {
        
        authenticationObject.createUser(withEmail: user.email, password: user.password ) { (user, error) in
            
            guard error == nil else {
                //onError
                if let error = error {
                    handler(nil, error)
                }
                return
            }
            //onSuccess
            if let user = user {
                handler(user, nil)
            }
        }
    }
    
    
    /// Reset Password for the associated Email Address
    ///
    /// - Parameters:
    ///   - email: associated email Address
    ///   - handler: Completion Handler with Bool Optional and Error Optional
    func resetPassword(email:String, handler: @escaping onCompletion) {
        
        authenticationObject.sendPasswordReset(withEmail: email) { (error) in
            
            guard error == nil else {
                handler(false, error)
                return
            }
            
            // onSuccess
            handler(true, nil)
        }
    }
    
    /// Update Password
    ///
    /// - Parameters:
    ///   - newPassword: New Password as String
    ///   - handler: Competion Handler with Bool Optional for state and Error Optional
    func updatePassword(newPassword: String, handler: @escaping onCompletion) {
        
        authenticationObject.currentUser?.updatePassword(to: newPassword, completion: { (error) in
            
            guard error == nil else {
                handler(false, error)
                return
            }
            
            handler(true, nil)
        })
    }
    
    
    /// Send Verification Mail
    ///
    /// - Parameter hanlder: completionHandler with Bool Optional and Error Optional
    func sendVerificationMail(hanlder: @escaping onCompletion) {
        
        authenticationObject.useAppLanguage()
        authenticationObject.currentUser?.sendEmailVerification(completion: { (error) in
            
            guard error == nil else {
                hanlder(false, error)
                return
            }
            
            //onSuccess
            hanlder(true, nil)
        })
    }
    
    /// Update Email Address for Existing Account
    ///
    /// - Parameters:
    ///   - newEmail: Email Address as String
    ///   - handler: completionHandler with User Optional and Error Optional
    func updateEmailAddress(newEmail: String, handler: @escaping completionHandler) {
        
        authenticationObject.currentUser?.updateEmail(to: newEmail, completion: { (error) in
            
            guard error == nil else {
                handler(nil, error)
                return
            }
            //onSuccess
            handler(self.authenticationObject.currentUser, nil)
        })
    }
    
    /// Update User Profile
    ///
    /// - Parameter handler: completion Handler with User Optional and Error Optional
    func updateProfile(handler: @escaping completionHandler) {
        
        let changeRequest = authenticationObject.currentUser?.createProfileChangeRequest()
        
        changeRequest?.displayName = ""
        
        // Save Changes
        changeRequest?.commitChanges(completion: { (error) in
            
            guard error == nil else {
                print("Error while Changing Profile Request ...")
                handler(nil, error)
                return
            }
            
            // Saved Change
            handler(self.authenticationObject.currentUser, nil)
        })
    }
    
    /// Return Bool State Wheather isLoggedIn or Not
    ///
    /// - Returns: User Object
    func isLoggedIn() -> User? {
        
        return authenticationObject.currentUser
    }
    
    /// Logout Session
    ///
    /// - Returns: Execution State
    func logout() -> Bool {
        do {
            try authenticationObject.signOut()
            return true
        }
        catch {
            return false
        }
    }
    
    
}

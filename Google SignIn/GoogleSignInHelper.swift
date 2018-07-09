//
//  GoogleHelper.swift
//  GoogleSignInSample
//
//  Created by Abhishek  Kumar Ravi on 04/07/18.
//  Copyright © 2018 Abhishek  Kumar Ravi. All rights reserved.
//

import Foundation
import GoogleSignIn

struct GoogleUser {
    var userID: String!
    var name: String!
    var email: String!
    var hasImage: Bool!
    var imagePath: URL?
}

class GoogleSignInHelper: NSObject, GIDSignInUIDelegate, GIDSignInDelegate {
    
    typealias GoogleSignInHanlder = (_ user:GoogleUser?, _ error: Error?)->()
    
    private var handler: GoogleSignInHanlder?
    private let instance = GIDSignIn.sharedInstance()
    public static let shared = GoogleSignInHelper()
    
    private func prepareGoogleUser(_ user: GIDGoogleUser) -> GoogleUser {
        
        var localUser = GoogleUser()
        localUser.userID = user.userID
        localUser.email = user.profile.email
        localUser.name = user.profile.givenName
        localUser.hasImage = user.profile.hasImage
        localUser.imagePath = user.profile.imageURL(withDimension: 250)
        
        return localUser
    }
    
    private func successfullLogged(user: GoogleUser) {
        if let completionHandler = handler {
            completionHandler(user, nil)
        }
    }
    
    private func failedHandler(error: Error) {
        if let completionHandler = handler {
            completionHandler(nil, error)
        }
    }
    
    public func initialize() {
        
        // Initialize sign-in
        instance?.clientID = GoogleConfig.oAuthKey //CLIENT_KEY
        instance?.delegate = GoogleSignInHelper.shared
        instance?.uiDelegate = GoogleSignInHelper.shared
    }
    
    public func requestForSignIn(onCompletion:@escaping GoogleSignInHanlder) {
        
        handler = onCompletion
        instance?.signIn()
    }
    
    public func requestForSignOut() {
        instance?.signOut()
    }
    
    func sign(_ signIn: GIDSignIn!, present viewController: UIViewController!) {
        
    }
    
    func sign(_ signIn: GIDSignIn!, dismiss viewController: UIViewController!) {
        
    }
    
    func sign(inWillDispatch signIn: GIDSignIn!, error: Error!) {
     
        //onGoogleSignInAction
    }
    
    func sign(_ signIn: GIDSignIn!, didSignInFor user: GIDGoogleUser!,
              withError error: Error!) {
        
        if let error = error {
            // onFailure
            failedHandler(error: error)
        } else {
            
            // onSuccessfull Authentication
            successfullLogged(user: prepareGoogleUser(user))
        }
    }
    
    func sign(_ signIn: GIDSignIn!, didDisconnectWith user: GIDGoogleUser!,
              withError error: Error!) {
        
        // onFailure
        failedHandler(error: error)
    }
}

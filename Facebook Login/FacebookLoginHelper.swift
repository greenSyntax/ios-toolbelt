//
//  FacebookLoginHelper.swift
//  FacebookSigInSample
//
//  Created by Abhishek  Kumar Ravi on 04/07/18.
//  Copyright © 2018 Abhishek  Kumar Ravi. All rights reserved.
//

import Foundation
import FBSDKCoreKit
import FBSDKLoginKit

struct FacebookUser {
    var name: String!
    var email: String!
    var userID: String!
    var imagePath: String?
}


class FacebookLoginHelper {
    
    private let manager = FBSDKLoginManager()
    private let facebookKeys = ["public_profile", "email"]
    private let graphDict = ["fields": "id, name, picture.type(large), email"]
    
    public static let shared = FacebookLoginHelper()
    
    private func prepareUser(dict:[String:Any]) -> FacebookUser  {
        
        var user = FacebookUser()
        user.name = dict["name"] as? String
        user.email = dict["email"] as? String
        user.userID = dict["id"] as? String
        
        return user
    }
    
    public func authenticate(view: UIViewController, onCompletion:@escaping (Bool)->()) {
        
        manager.logIn(withReadPermissions: facebookKeys, from: view) { (result, error) in
            if let status = result {
                if !status.isCancelled {
                    //onSuccess
                    onCompletion(true)
                }
                //onFail
                onCompletion(false)
            }
        }
    }
    
    public func getUserProfile(onCompletion:@escaping (FacebookUser)->()) {
        
        if FBSDKAccessToken.current() != nil {
            FBSDKGraphRequest(graphPath: "me", parameters: graphDict).start { (connection, result, error) in
                
                if let dict = result as? [String:Any] {
                    let user = self.prepareUser(dict: dict)
                    onCompletion(user)
                }
            }
        }
        else {
            //onError
        }
    }
    
    public func logout() {
        manager.logOut()
    }
    
}

//
//  WSManager.swift
//  DistanceMatrixSample
//
//  Created by Abhishek Ravi on 29/07/17.
//  Copyright © 2017 MovingPIN. All rights reserved.
//

import Foundation

extension Error {
    
}

enum ErrorModel:Error {
    
    case conectivity
    case invalidUrl
    case invalidResponse
    case noResponse
    case buisnessFailure
    
    var localizedDescription: String {
        switch self {
            
        case .conectivity:
            return NSLocalizedString("There is some issue in your network connectivity", comment: "Connectivity Error")
            
        case .invalidUrl:
            return NSLocalizedString("Endpoint URL which you've passed in invalid", comment: "Invalid URL")
            
        case .invalidResponse:
            return NSLocalizedString("Response Error", comment: "Response Error")
            
        case .noResponse:
            return NSLocalizedString("There might be invalid URL which has no response", comment: "No Response")
            
        case .buisnessFailure:
            return NSLocalizedString("Buisness Failure", comment: "Buisness Failure")
            
        }
    }
}

struct ApiStruct {
    
    var endpoint:URL?
    var headers:[String:Any]?
    var body:Any?
}

typealias handler = (Any?, ErrorModel?)->Void

class WSManager {
    
    static let shared = WSManager()
    
    
    func getResponse(api: ApiStruct, completion: @escaping handler) {
     
        let session = URLSession.shared
        
        guard let apiPath = api.endpoint else{
            
            completion(nil, ErrorModel.invalidUrl)
            return
        }
        
        // Prepare API Request
        let apiRequest = NSMutableURLRequest(url: apiPath, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 30.0) as URLRequest
        
        let task = session.dataTask(with: apiRequest) { (data, response, error) in
            
            guard let responseData = data else {
                completion(nil, ErrorModel.invalidResponse)
                return
            }
            
            let responseString = String(data: responseData, encoding: String.Encoding.utf8)
            
            if let json =  try? JSONSerialization.jsonObject(with: responseData, options: []) {
                
                //onSuccess
                completion(json, nil)
            }
            
        }
        
        task.resume()
    }
    
}

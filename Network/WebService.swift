//
//  WebService.swift
//  admin
//
//  Created by Abhishek  Kumar Ravi on 13/09/18.
//  Copyright © 2018 C Color. All rights reserved.
//

import Foundation

/// HTTP Methods
enum HttpVerb: String {
    case GET = "GET"
    case POST = "POST"
    case PUT = "PUT"
    case DELETE = "DELETE"
    case PATCH = "PATCH"
}

/// Publicaly Exposed API's Endpoint
enum Endpoint: String {
    case getSubmissions = "rpc/admin/getsubmissions"
    case evaluateUserSubmission = "evaluateusersubmisson"
}

/// Generic Enum which has either success (Resolve) or failure(Reject) case
enum Promise<T> {
    case resolve(T)
    case reject(Error)
}

/// Object Which encapsulates any API Request
struct API {
    let verb: HttpVerb
    let endpoint: Endpoint
    let headers:[String:String]?
    let body: Data?
}

class WebService {
    
    private let session = URLSession.shared
    
    static let shared = WebService()
    private init(){}
    
    private func prepareRequest(api: API) -> URLRequest {
        
        var request = URLRequest(url: prepareURI(endpoint: api.endpoint))
        request.allHTTPHeaderFields = api.headers
        request.httpMethod = api.verb.rawValue
        
        request.httpBody = api.body
        
        return request
    }
    
    /// GET Request
    ///
    /// - Parameters:
    ///   - api: API Object which has HTTP Method, API Endpoint, Headers and Body Data
    ///   - onCompletion: Completion Closure with Promise Object
    public func get<T:Codable>(_ api: API, onCompletion: @escaping (_ response: Promise<T>) -> ()) {
        
        session.dataTask(with: prepareURI(endpoint: api.endpoint)) { (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    //onError
                    onCompletion(Promise.reject(error))
                }
            }
            
            if let responseData = data, let serializedResponse = try? JSONDecoder().decode(T.self, from: responseData) {
                //onSuccess
                onCompletion(Promise.resolve(serializedResponse))
            }
            }.resume()
    }
    
    /// POST Request
    ///
    /// - Parameters:
    ///   - api: API Object which has HTTP Method, API Endpoint, Headers and Body Data
    ///   - onCompletion: Completion Closure which has Promise Object
    public func post<T: Codable>(_ api: API, onCompletion: @escaping (_ response: Promise<T>) -> ()) {
        
        let request = prepareRequest(api: api)
        
        session.dataTask(with: request) { (data, response, error) in
            
            if let error = error {
                DispatchQueue.main.async {
                    //onError
                    onCompletion(Promise.reject(error))
                }
            }
            
            if let httpResponse = response as? HTTPURLResponse {
                
                if httpResponse.statusCode == 200 {
                    
                    //debugPrint(String(data: data!, encoding: .utf8))
                    
                    if let responseData = data, let serializedResponse = try? JSONDecoder().decode(T.self, from: responseData) {
                        DispatchQueue.main.async {
                            //onSuccess
                            onCompletion(Promise.resolve(serializedResponse))
                        }
                    }
                }
                else {
                    DispatchQueue.main.async {
                        //onFailure
                        onCompletion(Promise.reject(NSError(domain: "API_RESPONSE", code: httpResponse.statusCode, userInfo: ["message":"Response is not successfull"])))
                        
                        //TODO: Create a enum which will adopt Error type and create custom Errors
                    }
                }
            }
            
            }.resume()
    }
}

extension WebService {
    
    /// Private Method which will return API URL for endpoint
    ///
    /// - Parameter endpoint: pass Endpoint enum Object
    /// - Returns: A Valid URL
    fileprivate func prepareURI(endpoint: Endpoint) -> URL {
        return URL(string: "\(serverAPIURL)\(endpoint.rawValue)") ?? URL(string: serverAPIURL)!
    }
    
}

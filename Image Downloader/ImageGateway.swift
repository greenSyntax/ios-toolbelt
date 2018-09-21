//
//  ImageDownloader.swift
//  admin
//
//  Created by Abhishek  Kumar Ravi on 21/09/18.
//  Copyright © 2018 C Color. All rights reserved.
//

import Foundation
import UIKit

class ImageGateway {
    
    func request(_ imagePath: URL, onCompletion: @escaping (_ image: UIImage?, _ error: Error?) -> ()) {
        
        // If Image is in Cache
        if let cacheData: NSData = CacheGateway.instance.get(key: imagePath.absoluteString), let imageData = cacheData as Data?  {
            
            if let cachedImage = UIImage(data: imageData) {
                
                print("Image from Cache for Key : \(imagePath.absoluteString)") //FIXME
                
                //onSuccess
                onCompletion(cachedImage, nil)
            }
        }
        
        // Else, Request from Network
        URLSession.shared.dataTask(with: imagePath) { (data, response, error) in
            
                guard error == nil else {
                    
                    //onError
                    DispatchQueue.main.async {
                        onCompletion(nil, error)
                    }
                    return
                }
                
                if let imageResponse = response as? HTTPURLResponse {
                    
                    guard imageResponse.statusCode == 200 else {
                        
                        // onFailure
                        DispatchQueue.main.async {
                            onCompletion(nil, AppError.failedWhileDownloadingImage)
                        }
                        return
                    }
                    
                    if let imageData = data, let actualImage = UIImage(data: imageData) {
                        
                        // Persist into Cache
                        CacheGateway.instance.set(key: imagePath.absoluteString, value: imageData as NSData)
                        
                        print("Image from Network for URL : \(imagePath.absoluteString)") //FIXME
                        
                        //onSuccess
                        DispatchQueue.main.async {
                            onCompletion(actualImage, nil)
                        }
                        
                    }
                    
                }
            
            }.resume()
        
    }
    
}

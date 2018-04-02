//
//  NetworkService.swift
//  VK_WITHOUT_PODS_SWIFT
//
//  Created by Victor on 02.04.2018.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

class NetworkService {
    
    private init() {}
    static let shared = NetworkService() // singleton
    
    public func getData( url: URL, completion: @escaping (Any) -> ()) {
        
        var urlRequest = URLRequest(url: url, cachePolicy: .reloadIgnoringCacheData, timeoutInterval: 10)
        
        urlRequest.httpMethod = "GET"
        
        let session = URLSession.shared
        
        session.dataTask(with: urlRequest) { (data, response, error) in
            
            guard let data = data, error == nil
                
                else {
                    print("something is wrong")
                    return
            }
            print("downloaded")
            DispatchQueue.main.async {
                completion(data)
            }
            }.resume()
    }
}

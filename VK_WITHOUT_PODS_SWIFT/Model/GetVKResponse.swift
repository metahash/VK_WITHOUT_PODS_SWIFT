//
//  GetVKResponse.swift
//  VK_WITHOUT_PODS_SWIFT
//
//  Created by Victor on 02.04.2018.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

struct GetVKResponse {
    
    var friends = [FriendsModel.Response.Items]()
    init(data: Any) throws {
        
        let decoder = JSONDecoder()
        let response = try decoder.decode(FriendsModel.self, from: data as! Data)
        
        self.friends = response.response.items
        
    }
}

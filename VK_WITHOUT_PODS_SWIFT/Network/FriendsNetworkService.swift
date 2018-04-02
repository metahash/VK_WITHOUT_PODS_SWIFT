//
//  FriendsNetworkService.swift
//  VK_WITHOUT_PODS_SWIFT
//
//  Created by Victor on 02.04.2018.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

class FriendsNetworkService {
    
    private init() {}
    
    static var friends = [FriendsModel.Response.Items]()
    
    static func getComments(userID:String, completion: @escaping(GetVKResponse) -> ()) {
        
        guard let url = URL(string: "https://api.vk.com/method/friends.get?user_id=\(userID)&name=order&fields=photo_50,photo_200_orig,bdate,city,country,education,universities&name_case=nom&v=5.71") else { return }
        
        NetworkService.shared.getData(url: url) { (data) in
            do {
                let response = try GetVKResponse(data: data)
                completion(response)
            } catch {
                print("something wrong after downloaded")
                print(error)
            }
        }
    }
}



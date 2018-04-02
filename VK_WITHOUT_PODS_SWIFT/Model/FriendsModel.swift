//
//  FriendsModel.swift
//  VK_WITHOUT_PODS_SWIFT
//
//  Created by Victor on 02.04.2018.
//  Copyright © 2018 Victor. All rights reserved.
//

import Foundation

struct FriendsModel           :Codable {
    struct Response           :Codable {
        struct Items          :Codable {
            
            struct Country    :Codable {
                let id        :Int?
                let title     :String?
            }
            
            struct City       :Codable {
                let id        :Int?
                let title     :String?
            }
            
            let country       :Country?
            let city          :City?
            let id            :Int?
            let first_name    :String?
            let last_name     :String?
            let bdate         :String?
            let photo_50      :String?
            let photo_200_orig:String?
        }
        let items             :[Items]
    }
    let response              :Response
}


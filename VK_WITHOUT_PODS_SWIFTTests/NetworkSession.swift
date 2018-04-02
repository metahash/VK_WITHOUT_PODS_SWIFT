//
//  NetworkSession.swift
//  VK_WITHOUT_PODS_SWIFTTests
//
//  Created by Victor on 02.04.2018.
//  Copyright © 2018 Victor. All rights reserved.
//

import XCTest
@testable import VK_WITHOUT_PODS_SWIFT

class NetworkSession: XCTestCase {
    var session: URLSession!
    override func setUp() {
        super.setUp()
        session = URLSession(configuration: .default)
    }
    
    override func tearDown() {
        session = nil
        super.tearDown()
    }
    
    func testRequestHasNotError() {
        //given
        let userID = "654"
        let url = URL(string: "https://api.vk.com/method/friends.get?user_id=\(userID)&name=order&fields=photo_50,photo_200_orig,bdate,city,country,education,universities&name_case=nom&v=5.71")!
        
        let expect = expectation(description: "Request test")
        
        //when
        session.dataTask(with: url) { ( _, _, error) in
            //            XCTFail("Error")  //for fail
            if error != nil {
                XCTFail("Error")
            }
            
            expect.fulfill()
            }.resume()
        
        //then
        waitForExpectations(timeout: 5.0) { (error) in
            if error != nil {
                XCTFail("Expect not full fill")
            }
        }
    }
}

//
//  ApiTest.swift
//  DataManagerTests
//
//  Created by GGsrvg on 03.05.2020.
//  Copyright © 2020 GGsrvg. All rights reserved.
//

import XCTest
import Combine
@testable import DataManager

class ApiTest: XCTestCase {
    
    var expectation: XCTestExpectation!
    
    private var sub : AnyCancellable?
    
    func testGetPosts(){
        expectation = expectation(description: "Testing GetPosts")
        expectation.expectedFulfillmentCount = 1
        
        getPosts()
        
        waitForExpectations(timeout: 5) { (error) in
            if let error = error {
                XCTFail("WaitForExpectationsWithTimeout errored: \(error)")
            }
        }
    }
    
    func getPosts(){
        sub = DataManager.shared.api.getPosts(first: 1, after: "", orderBy: .createdAt)
            .sink(receiveCompletion: { complete in
                switch complete{
                case .finished:
                    self.expectation.fulfill()
                case .failure(let error):
                    XCTAssert(false, error.localizedDescription)
                }
            }, receiveValue: { value in
                
            })
    }
}

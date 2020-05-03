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
    func testGetPosts(){
        let _ = DataManager.shared.api.getPosts(first: 1, after: "", orderBy: .createdAt)
            .sink(receiveCompletion: { complete in
                switch complete{
                case .finished:
                    XCTAssertTrue(false)
                case .failure(let error):
                    XCTAssertFalse(true, error.localizedDescription)
                }
                XCTAssertTrue(false)
            }, receiveValue: { value in

                XCTAssertTrue(false)
            })
    }
}

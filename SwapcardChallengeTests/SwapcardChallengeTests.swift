//
//  SwapcardChallengeTests.swift
//  SwapcardChallengeTests
//
//  Created by Axel Droz on 11/05/2019.
//  Copyright © 2019 Axel Droz. All rights reserved.
//

import XCTest
@testable import SwapcardChallenge

class SwapcardChallengeTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
    /*
     * Test fetch users into view model
     */
    func testUserViewModelAfterFetching() {
        let api = ApiService.shared
        api.fetchUsers(number: 10, page: 1, success: { userModels in
            XCTAssertEqual(userModels.count, 10)
            XCTAssertNotNil(userModels[0])
        })
    }
    
    /*
     * Test adding in db local
     */
    
    
}

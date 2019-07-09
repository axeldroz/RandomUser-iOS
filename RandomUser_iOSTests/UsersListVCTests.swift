//
//  UsersListVCTests.swift
//  SwapcardChallengeTests
//
//  Created by Axel Droz on 25/06/2019.
//  Copyright © 2019 Axel Droz. All rights reserved.
//

import XCTest
@testable import RandomUser_iOS

class UsersListVCTests: XCTestCase {
    
    var vc : UsersListVC = UsersListVC()
    var userModel : UserModel!

    override func setUp() {
        let name = NameModel(title: "mrs", first: "jose", last: "duran")
        let pictureModel = PictureModel(large: "https://randomuser.me/api/portraits/women/42.jpg", medium: "https://randomuser.me/api/portraits/med/women/42.jpg", thumbail: "https://randomuser.me/api/portraits/thumb/women/42.jpg")
        let login = Login(uuid: "73704d2a-abdf-45da-ac9d-ba2e6076c416", username: "ticklishpeacock712")
        let timezone = TimezoneModel(offset: "-11:00", description: "Midway Island, Samoa")
        let birthday = BirthdayModel(date: "1952-01-22T11:30:00Z", age: 67)
        let location = LocationModel(street: "2711 calle mota", city: "burgos", state: "galicia", timezone: timezone)
        self.userModel = UserModel(gender: "female", name: name, email: "jose.duran@example.com", phone: "654-656-441", picture: pictureModel, login: login, location: location, dob: birthday)
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
    
    func testAddFriend() {
        vc.models = [self.userModel]
        vc.addFriendToLocalDB(index: 0)
        
    }

}

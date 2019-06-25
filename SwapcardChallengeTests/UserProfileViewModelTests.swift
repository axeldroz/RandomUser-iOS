//
//  UserProfileViewModelTests.swift
//  SwapcardChallengeTests
//
//  Created by Axel Droz on 25/06/2019.
//  Copyright © 2019 Axel Droz. All rights reserved.
//

import XCTest
@testable import SwapcardChallenge

class UserProfileViewModelTests: XCTestCase {

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
     * Test related for the view model in ProfileVC
     */
    func testUserCellViewModel() {
        let name = NameModel(title: "mrs", first: "jose", last: "duran")
        let pictureModel = PictureModel(large: "https://randomuser.me/api/portraits/women/42.jpg", medium: "https://randomuser.me/api/portraits/med/women/42.jpg", thumbail: "https://randomuser.me/api/portraits/thumb/women/42.jpg")
        let login = Login(uuid: "73704d2a-abdf-45da-ac9d-ba2e6076c416", username: "ticklishpeacock712")
        let timezone = TimezoneModel(offset: "-11:00", description: "Midway Island, Samoa")
        let birthday = BirthdayModel(date: "1952-01-22T11:30:00Z", age: 67)
        let location = LocationModel(street: "2711 calle mota", city: "burgos", state: "galicia", timezone: timezone)
        let userModel = UserModel(gender: "female", name: name, email: "jose.duran@example.com", phone: "654-656-441", picture: pictureModel, login: login, location: location, dob: birthday)
        
        let viewModel = UserProfileViewModel(model: userModel)

        XCTAssertEqual(viewModel.age, "\(userModel.dob!.age!)")
        XCTAssertEqual(viewModel.city, userModel.location?.city)
        XCTAssertEqual(viewModel.email, userModel.email!)
        XCTAssertEqual(viewModel.fullname, (userModel.name?.first ?? "") + " " + (userModel.name?.last ?? ""))
        XCTAssertEqual(viewModel.gender, userModel.gender)
        XCTAssertEqual(viewModel.phone, userModel.phone)
        XCTAssertEqual(viewModel.imagePath, userModel.picture?.large ?? userModel.picture?.medium ?? userModel.picture?.thumbail ?? "")
    }
    
    /*
     * Test related for the view model in ProfileVC
     * When something is missing
     */
    func testUserCellViewModelWhenUnknownField() {
        let pictureModel = PictureModel(large: "https://randomuser.me/api/portraits/women/42.jpg", medium: "https://randomuser.me/api/portraits/med/women/42.jpg", thumbail: "https://randomuser.me/api/portraits/thumb/women/42.jpg")
        let login = Login(uuid: "73704d2a-abdf-45da-ac9d-ba2e6076c416", username: "ticklishpeacock712")
        let userModel = UserModel(gender: "female", name: nil, email: nil, phone: "654-656-441", picture: pictureModel, login: login, location: nil, dob: nil)
        
        let viewModel = UserProfileViewModel(model: userModel)
        
        XCTAssertEqual(viewModel.age, "")
        XCTAssertEqual(viewModel.city, "")
        XCTAssertEqual(viewModel.email, "")
        XCTAssertEqual(viewModel.fullname, login.username)
    }
    /*
     * Test related for the view model in ProfileVC
     * When it comes from Local DB
     */
    func testUserProfileViewModelFromFriend() {
        let friend = Friend()
        friend.age = "67"
        friend.city = "burgos"
        friend.email = "jose.duran@example.com"
        friend.firstname = "jose"
        friend.lastname = "duran"
        friend.gender = "female"
        friend.phone = "654-656-441"
        friend.picture = Picture()
        friend.picture?.thumbail = "https://randomuser.me/api/portraits/thumb/women/42.jpg"
        friend.picture?.medium = "https://randomuser.me/api/portraits/med/women/42.jpg"
        friend.picture?.large = "https://randomuser.me/api/portraits/women/42.jpg"
        friend.state = "galicia"
        friend.timezone = "Midway Island, Samoa"
        friend.title = "mrs"
        friend.username = "ticklishpeacock712"
        friend.uuid = "73704d2a-abdf-45da-ac9d-ba2e6076c416"
        
        let viewModel = UserProfileViewModel(model: friend)
        
        XCTAssertEqual(viewModel.age, friend.age)
        XCTAssertEqual(viewModel.city, friend.city)
        XCTAssertEqual(viewModel.email, friend.email)
        XCTAssertEqual(viewModel.fullname, (friend.firstname) + " " + (friend.lastname))
        XCTAssertEqual(viewModel.gender, friend.gender)
        XCTAssertEqual(viewModel.phone, friend.phone)
        XCTAssertEqual(viewModel.imagePath, friend.picture?.large ?? friend.picture?.medium ?? friend.picture?.thumbail ?? "")
    }

}

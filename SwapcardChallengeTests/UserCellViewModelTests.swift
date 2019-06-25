//
//  UserCellViewModelTests.swift
//  SwapcardChallengeTests
//
//  Created by Axel Droz on 25/06/2019.
//  Copyright © 2019 Axel Droz. All rights reserved.
//

import XCTest
@testable import SwapcardChallenge

class UserCellViewModelTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    /*
     * Test related for the UserCell in UsersListVC
     */
    func testUserCellViewModel() {
        let name = NameModel(title: "mrs", first: "jose", last: "duran")
        let pictureModel = PictureModel(large: "https://randomuser.me/api/portraits/women/42.jpg", medium: "https://randomuser.me/api/portraits/med/women/42.jpg", thumbail: "https://randomuser.me/api/portraits/thumb/women/42.jpg")
        let login = Login(uuid: "73704d2a-abdf-45da-ac9d-ba2e6076c416", username: "ticklishpeacock712")
        let timezone = TimezoneModel(offset: "-11:00", description: "Midway Island, Samoa")
        let birthday = BirthdayModel(date: "1952-01-22T11:30:00Z", age: 67)
        let location = LocationModel(street: "2711 calle mota", city: "burgos", state: "galicia", timezone: timezone)
        let userModel = UserModel(gender: "female", name: name, email: "jose.duran@example.com", phone: "654-656-441", picture: pictureModel, login: login, location: location, dob: birthday)
        
        let viewModel = UserCellViewModel(model: userModel)
        
        XCTAssertEqual(viewModel.email, "jose.duran@example.com")
        XCTAssertEqual(viewModel.fullName, (userModel.name?.first ?? "") + " " + (userModel.name?.last ?? ""))
        XCTAssertEqual(viewModel.imagePath, userModel.picture?.medium)
    }
    
    /*
     * Test related for the UserCell in UsersListVC
     * When something is missing
     */
    func testUserCellViewModelWhenUnknownField() {
        let login = Login(uuid: "73704d2a-abdf-45da-ac9d-ba2e6076c416", username: "ticklishpeacock712")
        let timezone = TimezoneModel(offset: "-11:00", description: "Midway Island, Samoa")
        let birthday = BirthdayModel(date: "1952-01-22T11:30:00Z", age: 67)
        let location = LocationModel(street: "2711 calle mota", city: "burgos", state: "galicia", timezone: timezone)
        let userModel = UserModel(gender: "female", name: nil, email: nil, phone: "654-656-441", picture: nil, login: login, location: location, dob: birthday)
        
        let viewModel = UserCellViewModel(model: userModel)
        
        XCTAssertEqual(viewModel.email, "unknown")
        XCTAssertEqual(viewModel.fullName, "unknown" + " " + "unknown")
        XCTAssertEqual(viewModel.imagePath, "")
    }
    
    /*
     * Test related for the UserCell in Favoris VC
     * When it comes from Local DB
     */
    func testUserCellViewModelFromFriend() {
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
        
        
        let viewModel = UserCellViewModel(model: friend)
        
        XCTAssertEqual(viewModel.email, "jose.duran@example.com")
        XCTAssertEqual(viewModel.fullName, (friend.firstname ?? "") + " " + (friend.lastname ?? ""))
        XCTAssertEqual(viewModel.imagePath, friend.picture?.medium)
    }

}

//
//  UserModel.swift
//  SwapcardChallenge
//
//  Created by Axel Drozdzynski on 13/05/2019.
//  Copyright © 2019 Axel Drozdzynski. All rights reserved.
//

import Foundation

struct TimezoneModel : Decodable {
    let offset : String?
    let description : String?
}

struct LocationModel : Decodable {
    let street : String?
    let city : String?
    let state : String?
    let timezone : TimezoneModel?
}

struct BirthdayModel : Decodable {
    let date : String?
    let age : Int?
}

struct NameModel : Decodable {
    let title : String?
    let first : String?
    let last : String?
}

struct PictureModel : Decodable {
    let large : String?
    let medium : String?
    let thumbail : String?
}

struct Login : Decodable {
    let uuid : String?
    let username : String?
}

struct UserModel : Decodable {
    let gender : String?
    let name : NameModel?
    let email : String?
    let phone : String?
    let picture : PictureModel?
    let login : Login?
    let location : LocationModel?
    let dob : BirthdayModel?
}

struct Root : Decodable {
    let results: [UserModel]?
}

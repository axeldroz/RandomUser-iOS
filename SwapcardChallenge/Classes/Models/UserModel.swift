//
//  UserModel.swift
//  SwapcardChallenge
//
//  Created by Axel Droz on 13/05/2019.
//  Copyright © 2019 Axel Droz. All rights reserved.
//

/*
 "location": {
 "street": "2711 calle mota",
 "city": "burgos",
 "state": "galicia",
 "postcode": 69633,
 "coordinates": {
 "latitude": "-24.9297",
 "longitude": "161.1145"
 },
 "timezone": {
 "offset": "-11:00",
 "description": "Midway Island, Samoa"
 }
 
 "dob": {
 "date": "1952-01-22T11:30:00Z",
 "age": 67
 },
 
 
 }*/

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

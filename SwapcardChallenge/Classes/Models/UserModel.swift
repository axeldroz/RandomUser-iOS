//
//  UserModel.swift
//  SwapcardChallenge
//
//  Created by Axel Droz on 13/05/2019.
//  Copyright © 2019 Axel Droz. All rights reserved.
//

import Foundation
import SwiftyJSON

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

struct UserModel : Decodable {
    let gender : String?
    let name : NameModel?
    let email : String?
    let picture : PictureModel?
}

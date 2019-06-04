//
//  Friend.swift
//  SwapcardChallenge
//
//  Created by Axel Droz on 29/05/2019.
//  Copyright © 2019 Axel Droz. All rights reserved.
//

import RealmSwift

class Friend : Object {
    @objc dynamic var id = 0
    @objc dynamic var username = ""
    @objc dynamic var gender : String = ""
    @objc dynamic var title : String = ""
    @objc dynamic var firstname : String = ""
    @objc dynamic var lastname : String = ""
    @objc dynamic var email : String = ""
    @objc dynamic var picture : Picture?
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

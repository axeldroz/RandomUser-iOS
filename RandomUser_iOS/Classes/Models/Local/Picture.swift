//
//  Picture.swift
//  RandomUser_iOS
//
//  Created by Axel Droz on 29/05/2019.
//  Copyright © 2019 Axel Droz. All rights reserved.
//

import RealmSwift

class Picture : Object {
    @objc dynamic var id = 0
    @objc dynamic var thumbail = ""
    @objc dynamic var medium = ""
    @objc dynamic var large = ""
    
    override static func primaryKey() -> String? {
        return "id"
    }
}

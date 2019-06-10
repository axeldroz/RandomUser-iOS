//
//  Friend.swift
//  SwapcardChallenge
//
//  Created by Axel Droz on 29/05/2019.
//  Copyright © 2019 Axel Droz. All rights reserved.
//

import RealmSwift

/*
 let imagePath : String
 let fullname : String
 let username : String
 let city : String
 let state : String
 let timezone : String
 let gender : String
 let age : String*/

class Friend : Object {
    @objc dynamic var id : Int = 0
    @objc dynamic var uuid : String = ""
    @objc dynamic var username : String = ""
    @objc dynamic var gender : String = ""
    @objc dynamic var title : String = ""
    @objc dynamic var firstname : String = ""
    @objc dynamic var lastname : String = ""
    @objc dynamic var email : String = ""
    @objc dynamic var phone : String = ""
    @objc dynamic var picture : Picture?
    @objc dynamic var city : String = ""
    @objc dynamic var state : String = ""
    @objc dynamic var age : String = ""
    @objc dynamic var timezone : String = ""
 
    override static func primaryKey() -> String? {
        return "uuid"
    }
    
    func fromModel (model: UserModel, id: Int) {
        let picture = Picture()
        guard let uuid = model.login?.uuid else {
            print ("user with the same uuid has already been added")
            return
        }
        self.firstname = model.name?.first ?? "unknown"
        self.lastname = model.name?.last ?? "unknown"
        self.email = model.email ?? "unknown"
        self.username = model.login?.username ?? ""
        self.id = id
        self.title = model.name?.title ?? "unknown"
        self.gender = model.gender ?? "unknown"
        picture.id = self.id
        picture.thumbail = model.picture?.thumbail ?? ""
        picture.medium = model.picture?.medium ?? ""
        picture.large = model.picture?.large ?? ""
        self.picture = picture
        self.uuid = uuid
        self.phone = model.phone ?? ""
        self.city = model.location?.city ?? ""
        self.state = model.location?.state ?? ""
        self.timezone = model.location?.timezone?.description ?? ""
        self.age = (model.dob!.age != nil) ? "\(model.dob!.age!)" : ""
    }
}

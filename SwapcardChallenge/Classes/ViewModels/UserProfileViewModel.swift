//
//  UserProfileViewModel.swift
//  SwapcardChallenge
//
//  Created by Axel Drozdzynski on 09/06/2019.
//  Copyright © 2019 Axel Drozdzynski. All rights reserved.
//

import Foundation

/*
 * UserProfileViewModel is used for profile view
 *
 */

struct UserProfileViewModel {
    let imagePath : String
    let fullname : String
    let username : String
    let city : String
    let state : String
    let timezone : String
    let gender : String
    let age : String
    let email : String
    let phone : String
    let addVisible : Bool
    
    //Depency Injection
    init(model : UserModel, exists: Bool = true) {
        self.imagePath = model.picture?.large ?? model.picture?.medium ?? model.picture?.thumbail ?? ""
        if (model.name?.first == nil && model.name?.last != nil) {
            self.fullname = model.name!.last!
        } else if (model.name?.first != nil && model.name?.last == nil) {
            self.fullname = model.name!.first!
        } else {
            if (model.name?.first == nil && model.name?.last == nil) {
                self.fullname = model.login?.username ?? "unknown"
            } else {
                self.fullname = model.name!.first! + " " + model.name!.last!
            }
        }
        self.username = "@" + (model.login?.username ?? "")
        self.city = model.location?.city ?? ""
        self.state = model.location?.state ?? ""
        self.timezone = model.location?.timezone?.description ?? ""
        self.gender = model.gender ?? ""
        self.age = (model.dob?.age != nil) ? "\(model.dob!.age!)" : ""
        self.email = model.email ?? ""
        self.phone = model.phone ?? ""
        self.addVisible = !exists
    }
    
    // DI from local db
    init(model : Friend) {
        self.imagePath = model.picture?.large ?? model.picture?.medium ?? model.picture?.thumbail ?? ""
        self.fullname = model.firstname + " " + model.lastname
        self.username = "@" + model.username
        self.city = model.city
        self.state = model.state
        self.timezone = model.timezone
        self.gender = model.gender
        self.age = model.age
        self.email = model.email
        self.phone = model.phone
        self.addVisible = false
    }
}

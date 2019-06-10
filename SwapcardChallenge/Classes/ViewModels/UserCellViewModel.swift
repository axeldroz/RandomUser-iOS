//
//  userModelView.swift
//  SwapcardChallenge
//
//  Created by Axel Drozdzynski on 13/05/2019.
//  Copyright © 2019 Axel Droz. All rights reserved.
//

import Foundation

/*
 * UserCellViewModel is used for displaying a user inside a users list
 *
 * imagePath : String?
 * fullName : String?
 * email : String?
 *
 */

struct UserCellViewModel {
    let imagePath : String
    let fullName : String
    let email : String
    
    //Depency Injection
    init(model : UserModel) {
        self.imagePath = model.picture?.medium ?? ""
        self.fullName = (model.name?.first ?? "Unknown") + " " + (model.name?.last ?? "Unkwown")
        self.email = model.email ?? "unkwnown"
    }
    
    // DI from local db
    init(model : Friend) {
        self.imagePath = model.picture?.medium ?? ""
        self.fullName = (model.firstname ) + " " + (model.lastname)
        self.email = model.email
    }
}
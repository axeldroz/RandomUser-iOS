//
//  userModelView.swift
//  SwapcardChallenge
//
//  Created by Axel Drozdzynski on 13/05/2019.
//  Copyright © 2019 Axel Droz. All rights reserved.
//

import Foundation

struct UserModelView {
    let imagePath : String?
    let fullName : String?
    let email : String?
    
    //Depency Injection
    init(model : UserModel) {
        self.imagePath = model.picture?.medium
        self.fullName = (model.name?.first ?? "Unknown") + " " + (model.name?.last ?? "Unkwown")
        self.email = model.email
    }
}

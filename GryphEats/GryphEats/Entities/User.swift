//
//  UserModel.swift
//  GryphEats
//
//  Created by Matthew Bebis on 10/16/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Foundation

struct User {
    
    var type: Int
    var username: String
    var password: String
    
    init(type: Int, username: String, password: String){
        self.type = type
        self.username = username
        self.password = password
    }
    
}

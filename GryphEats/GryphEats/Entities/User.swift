//
//  UserModel.swift
//  GryphEats
//
//  Created by Matthew Bebis on 10/16/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Foundation

// MARK: - User

struct User: Codable {
    
    // MARK: Type
    
    enum UserType: Int, Codable {
        case customer
        case restaurant
    }
    
    // MARK: Lifecycle
    
    init(type: UserType, username: String, password: String) {
        self.userType = type
        self.username = username
        self.password = password
    }
    
    // MARK: Internal
    
    let userType: UserType
    let username: String
    let password: String
    
}

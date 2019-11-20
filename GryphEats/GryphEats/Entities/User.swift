//
//  UserModel.swift
//  GryphEats
//
//  Created by Matthew Bebis on 10/16/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - User

class User: ObservableObject {
    
    // MARK: Lifecycle
    
    init(id: String, type: UserType, username: String, password: String) {
        self.id = id
        self.userType = type
        self.username = username
        self.password = password
    }
    
    // MARK: Internal
    
    let id: String
    let userType: UserType
    let username: String
    let password: String
    
}

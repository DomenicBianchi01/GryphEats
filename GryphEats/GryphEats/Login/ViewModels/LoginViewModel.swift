//
//  LoginViewModel.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-03.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Foundation
import Valet

// MARK: - LoginViewModel

class LoginViewModel {
    
    // MARK: LoginError
    
    enum LoginError: Error, LocalizedError {
        case invalidCredentials
        
        // MARK: Internal
        
        var recoverySuggestion: String? {
            switch self {
            case .invalidCredentials:
                return "Please check that your email and password are correct"
            }
        }
        
        var errorDescription: String? {
            return "Login Error"
        }
    }
    
    // MARK: Internal
    
    var loggedInUser: User? {
        guard let data = Valet.keychain.object(forKey: Valet.Key.user.rawValue) else {
            return nil
        }
        
        return try? JSONDecoder().decode(User.self, from: data)
    }

    func attemptLogin(username: String, password: String) -> Result<User, LoginViewModel.LoginError> {
        // TODO: The code below is just being used for testing purposes until the Login API is ready
        
        if username == restaurantUser.username && password == restaurantUser.password {
            saveCredentials(for: restaurantUser)
            return .success(restaurantUser)
        } else if username == customerUser.username && password == customerUser.password {
            saveCredentials(for: customerUser)
            return .success(customerUser)
        }
        
        return .failure(.invalidCredentials)
    }
    
    // MARK: Private
    
    private let restaurantUser = User(type: .restaurant, username: "Test", password: "password")
    private let customerUser = User(type: .customer, username: "customer", password: "password")
    
    private func saveCredentials(for user: User) {
        if let data = try? JSONEncoder().encode(user) {
            Valet.keychain.set(object: data, forKey: Valet.Key.user.rawValue)
        }
    }
}

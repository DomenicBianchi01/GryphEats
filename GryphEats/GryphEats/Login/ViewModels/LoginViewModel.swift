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
            "Please check that your email and password are correct"
        }
        
        var errorDescription: String? {
            "Login Error"
        }
    }
    
    // MARK: Internal
    
    var loggedInUser: User? {
        guard let data = Valet.keychain.object(forKey: Valet.Key.user.rawValue) else {
            return nil
        }
        
        return try? JSONDecoder().decode(User.self, from: data)
    }
    
    func attemptLogin(
        username: String,
        password: String,
        completion: @escaping (Result<User, LoginViewModel.LoginError>) -> Void)
    {
        if username == restaurantUser.username && password == restaurantUser.password {
            completion(.success(restaurantUser))
            return
        }
        
        GraphClient.shared.fetch(query: LoginUserQuery(email: username, password: password)) { result in
            switch result {
            case .success(let data):
                guard let userID = data.validateUser.account?.userId else {
                    return completion(.failure(.invalidCredentials))
                }
                
                //TODO: Only save credentials if user type is a customer
                self.saveCredentials(for: User(id: userID, type: .customer, username: username, password: ""))
                
                return completion(.success(User(id: userID, type: .customer, username: username, password: "")))
            case .failure:
                return completion(.failure(.invalidCredentials))
            }
        }
    }
    
    // MARK: Private
    
    private let restaurantUser = User(id: "1", type: .restaurant, username: "Test", password: "password")
    
    private func saveCredentials(for user: User) {
        if let data = try? JSONEncoder().encode(user) {
            Valet.keychain.set(object: data, forKey: Valet.Key.user.rawValue)
        }
    }
}

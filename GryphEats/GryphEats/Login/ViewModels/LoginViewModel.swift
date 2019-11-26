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
            return "Please check that your email and password are correct"
        }
        
        var errorDescription: String? {
            return "Login Error"
        }
    }
    
    // MARK: Internal
    
    var canAutoLoginUser: Bool {
        return Valet.keychain.string(forKey: Valet.Key.userUsername.rawValue) != nil &&
            Valet.keychain.string(forKey: Valet.Key.userPassword.rawValue) != nil
    }
    
    func attemptAutoLogin(completion: @escaping (Result<User, LoginViewModel.LoginError>) -> Void) {
        guard let username = Valet.keychain.string(forKey: Valet.Key.userUsername.rawValue),
            let password = Valet.keychain.string(forKey: Valet.Key.userPassword.rawValue) else {
                completion(.failure(.invalidCredentials))
                return
        }
        
        attemptLogin(username: username, password: password, completion: completion)
    }
    
    func attemptLogin(
        username: String,
        password: String,
        completion: @escaping (Result<User, LoginViewModel.LoginError>) -> Void)
    {        
        GraphClient.shared.fetch(query: LoginUserQuery(email: username, password: password)) { result in
            switch result {
            case .success(let data):
                guard let account = data.validateUser.account, data.validateUser.isValid == true else {
                    return completion(.failure(.invalidCredentials))
                }
                
                if account.userType == .customer {
                    self.saveCredentials(username: username, password: password)
                }
                
                return completion(.success(User(
                    id: account.userId,
                    type: account.userType,
                    username: username,
                    password: "")))
            case .failure:
                return completion(.failure(.invalidCredentials))
            }
        }
    }
    
    // MARK: Private
    
    private func saveCredentials(username: String, password: String) {
        Valet.keychain.set(string: username, forKey: Valet.Key.userUsername.rawValue)
        Valet.keychain.set(string: password, forKey: Valet.Key.userPassword.rawValue)
    }
}

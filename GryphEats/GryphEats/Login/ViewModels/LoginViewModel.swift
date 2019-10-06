//
//  LoginViewModel.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-03.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

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

    func attemptLogin() -> Result<Bool, LoginViewModel.LoginError> {
        //return .failure(.invalidCredentials)
       return .success(true)
    }
}

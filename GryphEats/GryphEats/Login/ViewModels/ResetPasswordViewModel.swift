//
//  ResetPasswordViewModel.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-11-10.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Foundation

// MARK: - ResetPasswordViewModel

class ResetPasswordViewModel {
    
    // MARK: ForgotPasswordError
    
    enum ResetPasswordError: Error, LocalizedError {
        case invalidPassword
        case updateError
        
        // MARK: Internal
        
        var recoverySuggestion: String? {
            switch self {
            case .invalidPassword:
                return "Please make sure that your password contains at least 6 characters."
            case .updateError:
                return "Your password could not be updated. Please try again."
            }
        }
        
        var errorDescription: String? {
            return "Error"
        }
    }
    
    // MARK: Internal
    
    func updatePassword(
        email: String,
        newPassword: String,
        completion: @escaping (Result<Bool, ResetPasswordError>) -> Void)
    {
        GraphClient.shared.perform(mutation: UpdatePasswordMutation(email: email, password: newPassword)) { result in
            switch result {
            case .success(let data):
                if data.success == true {
                    completion(.success(true))
                } else {
                    completion(.failure(.updateError))
                }
            case .failure:
                completion(.failure(.updateError))
            }
        }
    }
}

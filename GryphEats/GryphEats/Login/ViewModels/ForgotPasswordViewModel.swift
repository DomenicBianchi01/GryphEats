//
//  ForgotPasswordViewModel.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-11-10.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Foundation

// MARK: - ForgotPasswordViewModel

class ForgotPasswordViewModel {
    
    // MARK: ForgotPasswordError
    
    enum ForgotPasswordError: Error, LocalizedError {
        case emptyEmail
        case invalidEmail
        
        // MARK: Internal
        
        var recoverySuggestion: String? {
            switch self {
            case .emptyEmail:
                return "An email must be provided."
            case .invalidEmail:
                return "No account with the provided email was found."
            }
        }
        
        var errorDescription: String? {
            return "Error"
        }
    }
    
    // MARK: Internal
    
    func fetchSecurityQuestion(email: String, completion: @escaping (Result<String, ForgotPasswordError>) -> Void) {
        GraphClient.shared.fetch(query: SecurityQuestionQuery(email: email)) { result in
            switch result {
            case .success(let data):
                completion(.success(data.question))
            case .failure:
                completion(.failure(.invalidEmail))
            }
        }
    }
}

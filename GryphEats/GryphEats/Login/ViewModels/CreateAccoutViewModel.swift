//
//  CreateAccoutViewModel.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-11-13.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Foundation

// MARK: - CreateAccountViewModel

class CreateAccountViewModel {
    
    // MARK: CreateAccountError
    
    enum CreateAccountError: Error, LocalizedError {
        case accountCreationError
        
        // MARK: Internal
        
        var recoverySuggestion: String? {
            return "We could not create your account at this time. Please try again later."
        }
        
        var errorDescription: String? {
            return "Error"
        }
    }
    
    // MARK: Internal
    
    func createAccount(
        firstName: String,
        lastName: String,
        email: String,
        password: String,
        question: String,
        answer: String,
        completion: @escaping (Result<Bool, CreateAccountError>) -> Void)
    {
        GraphClient.shared.perform(mutation: RegisterUserMutation(
            firstName: firstName,
            lastName: lastName,
            email: email,
            password: password,
            question: question,
            answer: answer))
        { result in
            switch result {
            case .success(let data):
                if data.createUser?.success == true {
                    completion(.success(true))
                } else {
                    completion(.failure(.accountCreationError))
                }
            case .failure:
                completion(.failure(.accountCreationError))
            }
        }
    }
}

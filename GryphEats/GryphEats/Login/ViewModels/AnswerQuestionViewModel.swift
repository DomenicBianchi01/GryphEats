//
//  AnswerQuestionViewModel.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-11-10.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Foundation

// MARK: - AnswerQuestionViewModel

class AnswerQuestionViewModel {
    
    // MARK: ForgotPasswordError
    
    enum AnswerQuestionError: Error, LocalizedError {
        case emptyAnswer
        case invalidAnswer
        
        // MARK: Internal
        
        var recoverySuggestion: String? {
            switch self {
            case .emptyAnswer:
                return "An answer must be provided."
            case .invalidAnswer:
                return "The answer provided is incorrect. Please try again."
            }
        }
        
        var errorDescription: String? {
            return "Error"
        }
    }
    
    // MARK: Internal
    
    func validateSecurityAnswer(
        email: String,
        answer: String,
        completion: @escaping (Result<Bool, AnswerQuestionError>) -> Void)
    {
        GraphClient.shared.fetch(query: ValidateSecurityAnswerQuery(email: email, answer: answer)) { result in
            switch result {
            case .success(let data):
                if data.isCorrect {
                    completion(.success(true))
                } else {
                    completion(.failure(.invalidAnswer))
                }
            case .failure:
                completion(.failure(.invalidAnswer))
            }
        }
    }
}

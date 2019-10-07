//
//  LandingState.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-04.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - LandingState

class LandingState: ObservableObject {
    
    // MARK: State
    
    enum State {
        case answerQuestion
        case forgotPassword
        case info
        case login
        case resetPassword
        case security
    }
    
    // MARK: LandingError
    
    enum LandingError: Error, LocalizedError {
        case emptyFields
        case invalidPassword
        
        // MARK: Internal
        
        var recoverySuggestion: String? {
            switch self {
            case .emptyFields:
                return "You have left one or more fields empty. All fields are required to continue."
            case .invalidPassword:
                return "Please make sure that your password contains at least 6 characters."
            }
        }
        
        var errorDescription: String? {
            return "Unable To Continue"
        }
    }
    
    // MARK: Internal
    
    @Published var name: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    
    @Published var question: String = ""
    @Published var answer: String = ""
    
    @Published var state: State = .login {
        willSet {
            previousState = state
        }
    }
    
    private(set) var previousState: State = .login
    
    func validateBasicInfoInput() -> LandingError? {
        if !basicInfoComplete {
            return .emptyFields
        } else if !isPasswordValid {
            return .invalidPassword
        }
        
        return nil
    }
    
    func validateSecurityQuestion() -> LandingError? {
        if !securityQuestionComplete {
            return .emptyFields
        }
        
        return nil
    }
    
    func validateForgotPasswordInput() -> LandingError? {
        if email.isEmpty {
            return .emptyFields
        }
        
        return nil
    }
    
    func validateForgotPasswordAnswerInput() -> LandingError? {
        if answer.isEmpty {
            return .emptyFields
        }
        
        return nil
    }
    
    func validateResetPasswordInput() -> LandingError? {
        if answer.isEmpty {
            return .emptyFields
        }
        
        return nil
    }
    
    func validatePasswordInput() -> LandingError? {
        if !isPasswordValid {
            return .invalidPassword
        }
        
        return nil
    }
    
    func reset() {
        name = ""
        email = ""
        password = ""
        question = ""
        answer = ""
        state = .login
    }
    
    // MARK: Private
    
    private var isPasswordValid: Bool {
        return password.count >= 6
    }
    
    private var basicInfoComplete: Bool {
        return !(name.isEmpty || email.isEmpty || password.isEmpty)
    }
    
    private var securityQuestionComplete: Bool {
        return !(question.isEmpty || answer.isEmpty)
    }
}

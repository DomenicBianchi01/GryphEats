//
//  RegistrationState.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-04.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - RegistrationState

class RegistrationState: ObservableObject {
    
    // MARK: State
    
    enum State {
        case login
        case info
        case security
    }
    
    // MARK: RegistrationError
    
    enum RegistrationError: Error, LocalizedError {
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
            return "Registration Error"
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
    
    func validateBasicInfoInput() -> RegistrationError? {
        if !basicInfoComplete {
            return .emptyFields
        } else if !isPasswordValid {
            return .invalidPassword
        }
        
        return nil
    }
    
    func validateSecurityQuestion() -> RegistrationError? {
        if !securityQuestionComplete {
            return .emptyFields
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

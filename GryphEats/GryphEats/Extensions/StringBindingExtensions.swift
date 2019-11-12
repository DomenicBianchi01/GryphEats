//
//  StringBindingExtensions.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-11-11.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Foundation

// MARK: - StringBindingExtensions

extension Optional where Wrapped == String {
    
    // MARK: Internal
    
    /// When the binding contains an optional string, this property will either return the value or an empty string (if the actual value of the binding is `nil`)
    var safelyUnwrapped: String {
        get {
            return self ?? ""
        }
        set {
            self = newValue.isEmpty ? nil : newValue
        }
    }
}

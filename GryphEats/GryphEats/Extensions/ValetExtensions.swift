//
//  ValetExtensions.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-17.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Valet

// MARK: - Valet

extension Valet {
    
    // MARK: Keys
    
    enum Keys: String {
        case paymentMethods
    }
    
    // MARK: Internal
    
    static var keychain: Valet {
        // Based on the contents of the `Identifier`, it is 100% safe to force unwrap
        return Valet.valet(with: Identifier(nonEmpty: "GryphEats")!, accessibility: .whenUnlocked)
    }
}

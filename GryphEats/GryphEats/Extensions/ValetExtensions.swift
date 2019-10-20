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
    
    // MARK: Internal
    
    static var secureEnclave: SecureEnclaveValet {
        // Based on the contents of the `Identifier`, it is 100% safe to force unwrap
        return SecureEnclaveValet.valet(with: Identifier(nonEmpty: "GryphEats")!, accessControl: .userPresence)
    }
}

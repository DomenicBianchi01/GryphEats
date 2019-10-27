//
//  AccountViewModel.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-27.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI
import Valet

// MARK: - AccountViewModel

class AccountViewModel {
    
    // MARK: Row
    
    struct Row: Identifiable {
        
        enum ID: Int {
            case logout
        }
        
        // MARK: Internal
        
        let id: ID
        let text: String
        let alignment: Alignment
        let foregroundColor: Color
        
    }
    
    // MARK: Internal
    
    var rows: [Row] {
        [Row(id: .logout, text: "Logout", alignment: .center, foregroundColor: .guelphRed)]
    }
    
    func clearKeychain() {
        Valet.keychain.removeAllObjects()
    }
}

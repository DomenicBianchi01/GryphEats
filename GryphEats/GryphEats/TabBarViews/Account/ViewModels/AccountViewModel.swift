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
        
        // MARK: ID
        
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
        [Row(id: .logout, text: "Logout", alignment: .center, foregroundColor: .guelphRed(for: colorScheme))]
    }
    
    func logout(user: User) {
        guard let uuid = UIDevice.current.identifierForVendor?.uuidString else {
            return
        }
        
        GraphClient.shared.perform(
            mutation: UnregisterFromPushNotificationsMutation(userID: user.id, uuid: uuid))
        { result in
            switch result {
            case .success(let data):
                print(data.didUnregister ?? false)
            case .failure(let error):
                print("UNREGISTER ERROR")
                print(error)
            }
        }
        
        Valet.keychain.removeAllObjects()
        loggedInUserID = nil
    }
    
    // MARK: Private
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
}

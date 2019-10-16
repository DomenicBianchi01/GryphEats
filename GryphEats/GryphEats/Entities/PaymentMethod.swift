//
//  PaymentMethod.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-15.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - PaymentMethod

struct PaymentMethod: Identifiable {
    
    // MARK: CardType
    
    enum CardType {
        case student(balance: Double)
        case credit
        case applePay
    }
    
    // MARK: Lifecycle
    
    init(cardType: CardType, accountName: String, accountNumber: String) {
        self.cardType = cardType
        self.accountName = accountName
        self.accountNumber = accountNumber
        self.id = accountNumber
    }
    
    // MARK: Internal
    
    let cardType: CardType
    let accountName: String
    let accountNumber: String
    
    let id: String
    
}

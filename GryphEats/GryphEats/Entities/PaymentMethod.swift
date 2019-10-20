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
    
    enum CardType: Equatable {
        case student(mealPlanType: MealPlanType) // TODO: Balance
        case mastercard
        case visa
    }
    
    // MARK: MealPlanType
    
    enum MealPlanType {
        case onCampus
        case ultra
    }
    
    // MARK: Lifecycle
    
    init(cardType: CardType, accountName: String, accountNumber: Int) {
        self.cardType = cardType
        self.accountName = accountName
        self.accountNumber = accountNumber
        self.id = accountNumber
    }
    
    // MARK: Internal
    
    let cardType: CardType
    let accountName: String
    let accountNumber: Int
    
    let id: Int
    
    var lastFourDigits: String {
        return String(String(accountNumber).suffix(4))
    }
}

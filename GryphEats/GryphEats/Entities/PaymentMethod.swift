//
//  PaymentMethod.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-15.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - PaymentMethod

struct PaymentMethod: Identifiable, Codable {
    
    // MARK: CardType
    
    enum CardType: Equatable, Codable {
        case student(mealPlanType: MealPlanType) // TODO: Balance
        case mastercard
        case visa
        
        // MARK: CodingKeys
        
        private enum CodingKeys: String, CodingKey {
            case mealPlanType
            case creditCardType
        }
        
        // MARK: Lifecycle
        
        init(from decoder: Decoder) throws {
            let container = try decoder.container(keyedBy: CodingKeys.self)
            
            if let mealPlanType = try container.decodeIfPresent(MealPlanType.self, forKey: .mealPlanType) {
                self = .student(mealPlanType: mealPlanType)
                return
            } else if let creditCardType = try container.decodeIfPresent(Int.self, forKey: .creditCardType) {
                if creditCardType == CardProvider.mastercard.rawValue {
                    self = .mastercard
                    return
                } else if creditCardType == CardProvider.visa.rawValue {
                    self = .visa
                    return
                }
            }
            
            throw DecodingError.dataCorrupted(DecodingError.Context(
                codingPath: decoder.codingPath,
                debugDescription: "Could not decode value(s) to CardType"))
        }
        
        // MARK: Internal
        
        func encode(to encoder: Encoder) throws {
            var container = encoder.container(keyedBy: CodingKeys.self)
            
            switch self {
            case .student(let mealPlanType):
                try container.encode(mealPlanType, forKey: .mealPlanType)
            case .mastercard:
                try container.encode(CardProvider.mastercard.rawValue, forKey: .creditCardType)
            case .visa:
                try container.encode(CardProvider.visa.rawValue, forKey: .creditCardType)
            }
        }
    }
    
    // MARK: MealPlanType
    
    enum MealPlanType: Int, Codable {
        case onCampus
        case ultra
    }
    
    // MARK: CodingKeys
    
    private enum CodingKeys: String, CodingKey {
        case cardType
        case accountName
        case accountNumber
    }
    
    // MARK: Lifecycle
    
    init(cardType: CardType, accountName: String, accountNumber: Int) {
        self.cardType = cardType
        self.accountName = accountName
        self.accountNumber = accountNumber
        self.id = accountNumber
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.cardType = try container.decode(CardType.self, forKey: .cardType)
        self.accountName = try container.decode(String.self, forKey: .accountName)
        
        let accountNumber = try container.decode(Int.self, forKey: .accountNumber)
        
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

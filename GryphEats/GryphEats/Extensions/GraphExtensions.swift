//
//  GraphEquatableExtensions.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-28.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Foundation

// GraphQL structs do not conform to `Equatable` or `Identifiable` by default.

// MARK: - FoodItemDetails

extension FoodItemDetails: Equatable {
    
    // MARK: Public
    
    public static func == (lhs: FoodItemDetails, rhs: FoodItemDetails) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.price == rhs.price
    }
}

extension FoodItemDetails: Identifiable { }

// MARK: - FoodItemDetails.Ingredient

extension FoodItemDetails.Ingredient: Equatable {
    public static func == (lhs: FoodItemDetails.Ingredient, rhs: FoodItemDetails.Ingredient) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}

extension FoodItemDetails.Ingredient: Identifiable { }

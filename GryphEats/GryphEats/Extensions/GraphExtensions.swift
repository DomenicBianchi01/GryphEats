//
//  GraphEquatableExtensions.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-28.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Foundation

// The typealias' below exist just for convenience

typealias GraphRestaurant = RestaurantMenusQuery.Data.Restaurant
typealias Menu = GraphRestaurant.Menu
typealias GraphFoodItem = FoodItemDetails
typealias GraphOrder = UserOrdersQuery.Data.GetOrdersByUserId

// GraphQL structs do not conform to `Equatable` or `Identifiable` by default.

// MARK: - GraphFoodItem

extension GraphFoodItem: Equatable {
    
    // MARK: Public
    
    public static func == (lhs: FoodItemDetails, rhs: FoodItemDetails) -> Bool {
        return lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.price == rhs.price
    }
}

extension GraphFoodItem: Identifiable { }

// MARK: - GraphFoodItem.Ingredient

extension FoodItemDetails.Ingredient: Equatable {
    public static func == (lhs: FoodItemDetails.Ingredient, rhs: FoodItemDetails.Ingredient) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name
    }
}

extension GraphFoodItem.Ingredient: Identifiable { }

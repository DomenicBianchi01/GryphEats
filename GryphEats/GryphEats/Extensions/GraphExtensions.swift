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

// GraphQL structs do not conform to `Equatable` by default.

// MARK: - GraphFoodItem

extension GraphFoodItem: Equatable {
    
    // MARK: Public
    
    public static func == (lhs: FoodItemDetails, rhs: FoodItemDetails) -> Bool {
        lhs.id == rhs.id &&
            lhs.name == rhs.name &&
            lhs.price == rhs.price
    }
}

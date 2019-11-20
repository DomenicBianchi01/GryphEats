//
//  RestaurantFoodItem.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-07.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - RestaurantFoodItem

struct RestaurantFoodItem: Equatable {
    
    // MARK: Internal
    
    let foodItem: GraphFoodItem
    var selectedIngredients: [GraphFoodItem.Ingredient] = []
    let restaurantId: String
    let restaurantName: String
    
}

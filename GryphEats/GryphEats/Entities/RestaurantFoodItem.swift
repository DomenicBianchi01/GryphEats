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
    
    // MARK: Lifecycle
    
    init(
        foodItem: FoodItemDetails,
        imageURL: String? = nil,
        selectedIngredients: [FoodItemDetails.Ingredient] = [],
        restaurantId: String,
        restaurantName: String)
    {
        self.foodItem = foodItem
        self.imageURL = imageURL
        self.selectedIngredients = selectedIngredients
        self.restaurantId = restaurantId
        self.restaurantName = restaurantName
    }
    
    // MARK: Internal
    
    let foodItem: FoodItemDetails
    let imageURL: String? //Temp solution. Need to update `foodItem` to not be `FoodItemDetails`, rather a `MenuItem`
    var selectedIngredients: [FoodItemDetails.Ingredient]
    let restaurantId: String
    let restaurantName: String
    
}

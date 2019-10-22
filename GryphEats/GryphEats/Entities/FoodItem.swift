//
//  FoodItem.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-07.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - FoodItem

struct FoodItem: Identifiable, Equatable {
    
    // MARK: Lifecycle
    
    init(id: Int, name: String, imageName: String, ingredients: [Ingredient] = []) {
        self.id = id
        self.name = name
        self.imageName = imageName
        self.ingredients = ingredients
    }
    
    // MARK: Internal
    
    let id: Int
    let name: String
    let imageName: String
    let ingredients: [Ingredient]
    let price: Double = 9.99
    
}

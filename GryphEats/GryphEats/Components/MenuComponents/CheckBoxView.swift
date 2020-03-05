//
//  CheckBoxView.swift
//  GryphEats
//
//  Created by Owner on 11/2/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - IngredientSelection

struct IngredientSelection: Identifiable {
    
    // MARK: Lifecycle
    
    init(ingredient: FoodItemDetails.Ingredient, isSelected: Bool) {
        self.ingredient = ingredient
        self.isSelected = isSelected
        self.id = ingredient.id
    }
    
    // MARK: Internal
    
    let ingredient: FoodItemDetails.Ingredient
    let isSelected: Bool
    let id: String
    
}

// MARK: - CheckBoxView

struct CheckBoxView: View {
    
    // MARK: Lifecycle
    
    init(ingredients: [IngredientSelection], onTap: @escaping (FoodItemDetails.Ingredient) -> Void) {
        self.ingredients = ingredients
        self.onTap = onTap
        self.hapticGenerator.prepare()
    }
    
    // MARK: Internal
    
    var body: some View {
        List {
            ForEach(ingredients) { ingredientSelection in
                CheckBoxRow(
                    itemName: ingredientSelection.ingredient.name,
                    isSelected: ingredientSelection.isSelected)
                {
                    self.hapticGenerator.generate()
                    self.onTap(ingredientSelection.ingredient)
                }
            }.listConfiguration(backgroundColor: .cardBackground(for: colorScheme))
        }.onAppear {
            UITableViewCell.appearance().selectionStyle = .none
            UITableView.appearance().backgroundColor = .cardBackground
        }.onDisappear {
            UITableViewCell.appearance().selectionStyle = .default
        }
    }
    
    // MARK: Private
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    private let ingredients: [IngredientSelection]
    private let onTap: (FoodItemDetails.Ingredient) -> Void
    private let hapticGenerator = HapticGenerator(feedbackStyle: .medium)
    
}

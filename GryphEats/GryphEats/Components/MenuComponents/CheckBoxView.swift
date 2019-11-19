//
//  CheckBoxView.swift
//  GryphEats
//
//  Created by Owner on 11/2/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - CheckBoxView

struct CheckBoxView: View {
    
    // MARK: Lifecycle
    
    init(ingredients: [GraphFoodItem.Ingredient], onTap: @escaping (GraphFoodItem.Ingredient) -> Void) {
        self.ingredients = ingredients
        self.onTap = onTap
    }
    
    // MARK: Internal
    
    var body: some View {
        List {
            ForEach(ingredients) { ingredient in
                CheckBoxRow(itemName: ingredient.name) {
                    self.onTap(ingredient)
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
    
    private let ingredients: [GraphFoodItem.Ingredient]
    private let onTap: (GraphFoodItem.Ingredient) -> Void
    
}

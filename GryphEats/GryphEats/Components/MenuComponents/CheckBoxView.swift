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
    
    init(ingredients: [Ingredient], onTap: @escaping () -> Void) {
        self.ingredients = ingredients
        self.onTap = onTap
    }
    
    // MARK: Internal
    
    var body: some View {
        List(ingredients) { ingredient in
            CheckBoxRow(itemName: ingredient.name, onTap: self.onTap)
        }.onAppear {
            UITableViewCell.appearance().selectionStyle = .none
            UITableView.appearance().backgroundColor = .white
        }.onDisappear {
            UITableViewCell.appearance().selectionStyle = .default
        }
    }
    
    // MARK: Private
    
    private let ingredients: [Ingredient]
    private let onTap: () -> Void
    
}

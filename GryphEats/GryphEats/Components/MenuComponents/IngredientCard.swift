//
//  IngredientCard.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-10.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - IngredientCard

struct IngredientCard: View {
    
    // MARK: Lifecycle
    
    init(ingredient: Ingredient, selectionUpdated: @escaping (Bool) -> Void) {
        self.ingredient = ingredient
        self.selectionUpdated = selectionUpdated
    }
    
    // MARK: Internal
    
    var body: some View {
        VStack {
            Image(ingredient.imageName)
                .resizable()
                .frame(width: 44, height: 44)
                .padding()
                .clipShape(Circle())
                .overlay(Circle().stroke(isSelected ? Color.guelphYellow : Color.secondary, lineWidth: 2))
                .onTapGesture {
                    self.isSelected.toggle()
                }
            Text(ingredient.name)
                .font(.system(size: 10))
                .foregroundColor(.gray)
        }.padding(.vertical)
            .padding(.horizontal, 10)
    }
    
    @State private var isSelected: Bool = false {
        didSet {
            selectionUpdated(isSelected)
        }
    }
    
    // MARK: Private
    
    private let selectionUpdated: (Bool) -> Void
    private let ingredient: Ingredient
    
}

struct IngredientCard_Previews: PreviewProvider {
    static var previews: some View {
        IngredientCard(ingredient: Ingredient(id: 0, name: "Tomato", imageName: "tomato")) { _ in }
    }
}

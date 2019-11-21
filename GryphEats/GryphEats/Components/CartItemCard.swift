//
//  CartItemCard.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-14.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - CartItemCard

struct CartItemCard: View {
    
    // MARK: Lifecycle
    
    init(item: RestaurantFoodItem, editAction: (() -> Void)? = nil, deleteAction: (() -> Void)? = nil) {
        self.item = item
        self.editAction = editAction
        self.deleteAction = deleteAction
    }
    
    // MARK: Internal
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.foodItem.name)
                    .font(.headline)
                    .padding(.bottom, item.restaurantName.isEmpty ? 10 : 0)
                
                if !item.restaurantName.isEmpty {
                    Text(item.restaurantName)
                    .font(.footnote)
                    .foregroundColor(.gray)
                    .padding(.bottom, 10)
                }
                
                ForEach(item.selectedIngredients) { ingredient in
                    Text("• " + ingredient.name)
                        .font(.footnote)
                        .foregroundColor(.gray)
                }
                
                Text((item.foodItem.price).asDollarString)
                    .font(.subheadline)
                    .foregroundColor(.guelphRed(for: colorScheme))
                    .padding(.top, item.selectedIngredients.isEmpty ? 0 : 10)
            }.padding(.horizontal, 20)
                .padding([.top, .bottom], 10)
            
            Spacer()
            
            if deleteAction != nil {
                Button(action: deleteAction!) {
                    Image(systemName: "trash").foregroundColor(.guelphRed(for: colorScheme))
                }.padding()
            }
        }.background(Color.cardBackground(for: colorScheme))
            .cornerRadius(5)
            .padding(.all, 10)
            .shadow(radius: 2)
            .onTapGesture {
                self.editAction?()
        }
    }
    
    // MARK: Private
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    private let item: RestaurantFoodItem
    private let deleteAction: (() -> Void)?
    private let editAction: (() -> Void)?
    
}

struct CartItemCard_Previews: PreviewProvider {
    static var previews: some View {
        VStack(spacing: 0) {
            CartItemCard(
                item: RestaurantFoodItem(
                    foodItem: GraphFoodItem(id: "1", name: "Hamburger 1", price: 2.00, inStock: true),
                    selectedIngredients: [
                        GraphFoodItem.Ingredient(id: "0", name: "Lettuce"),
                        GraphFoodItem.Ingredient(id: "1", name: "Lettuce"),
                        GraphFoodItem.Ingredient(id: "2", name: "Lettuce")
                    ],
                    restaurantId: "1",
                    restaurantName: "100 Mile Grill"),
                deleteAction: {})
            CartItemCard(
                item: RestaurantFoodItem(
                    foodItem: GraphFoodItem(id: "2", name: "Hamburger 2", price: 2.00, inStock: true),
                    restaurantId: "1",
                    restaurantName: "100 Mile Grill"),
                deleteAction: {})
        }.background(Color.lightGray(for: .light))
    }
}

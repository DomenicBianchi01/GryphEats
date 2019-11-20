//
//  ItemOverview.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-09.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - ItemOverview

struct ItemOverview: View, Dismissable {
    
    // MARK: DisplayMode
    
    enum DisplayMode {
        /// Use this if this view is being displayed because the user tapped on a menu item
        case new
        /// Use this if this view is being displayed because the user wants to edit an item already added to their cart
        case edit
    }
    
    // MARK: Lifecycle
    
    init(item: RestaurantFoodItem, displayMode: DisplayMode = .new) {
        self.item = item
        self.displayMode = displayMode
        self.ingredientsHolder.selectedIngredients = item.selectedIngredients
    }
    
    // MARK: Internal
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { geometry in
                Image("hamburger") //TODO
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.vertical)
                    .frame(maxWidth: geometry.size.width, maxHeight: geometry.size.height)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(item.foodItem.name)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                    Text(item.foodItem.price.asDollarString)
                        .foregroundColor(.guelphYellow)
                        .fontWeight(.semibold)
                }.padding(.leading, 20)
                Spacer()
            }.padding(.top, 75)
            
            SlideOverCard(handleText: "Pull Up To Customize") {
                VStack(alignment: .leading) {
                    ActionButton(text: self.displayMode == .new ? "Add To Order" : "Update Item") {
                        if self.displayMode == .new {
                            var mutableItem = self.item
                            mutableItem.selectedIngredients = self.ingredientsHolder.selectedIngredients
                            
                            self.cart.items.append(mutableItem)
                        } else {
                            guard let index = self.cart.items.firstIndex(where: { $0 == self.item }) else {
                                return
                            }
                            
                            self.cart.items[index].selectedIngredients = self.ingredientsHolder.selectedIngredients
                        }
                        
                        self.dismiss()
                    }.padding(.bottom, 30)
                    
                    Text("Ingredients")
                        .bold()
                        .padding(.leading)
                    
                    CheckBoxView(
                        ingredients: self.item.foodItem.ingredients?.map {
                            IngredientSelection(
                                ingredient: $0,
                                isSelected: self.ingredientsHolder.selectedIngredients.contains($0))
                            } ?? [],
                        onTap: { selectedIngredient in
                            if let index = self.ingredientsHolder.selectedIngredients.firstIndex(where:
                                { $0 == selectedIngredient })
                            {
                                self.ingredientsHolder.selectedIngredients.remove(at: index)
                            } else {
                                self.ingredientsHolder.selectedIngredients.append(selectedIngredient)
                            }
                    }).padding(.bottom, 150)
                }
            }
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: Private
    
    @EnvironmentObject private var cart: Cart
    
    private let item: RestaurantFoodItem
    private let displayMode: DisplayMode
    private let ingredientsHolder = IngredientsHolder()
    
}

// MARK: - IngredientsHolder

private class IngredientsHolder {
    
    // MARK: Internal
    
    var selectedIngredients: [GraphFoodItem.Ingredient] = []
    
}

// MARK: - ItemOverview_Previews

struct ItemOverview_Previews: PreviewProvider {
    static var previews: some View {
        ItemOverview(
            item: RestaurantFoodItem(
                foodItem: GraphFoodItem(id: "1", name: "Hamburger 1", price: 2, isavailable: true),
                restaurantId: "1",
                restaurantName: "100 Mile Grill"))
            .environmentObject(Cart(items: []))
    }
}

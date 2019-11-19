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
    
    // MARK: Lifecycle
    
    init(item: RestaurantFoodItem) {
        self.item = item
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
                    ActionButton(text: "Add To Order") {
                        var mutableItem = self.item
                        mutableItem.selectedFoodItemIngredients = self.ingredientsHolder.selectedIngredients
                        
                        self.cart.items.append(mutableItem)
                        self.dismiss()
                    }.padding(.bottom, 30)
                    
                    Text("Ingredients")
                        .bold()
                        .padding(.leading)
                    
                    CheckBoxView(
                        ingredients: self.item.foodItem.ingredients ?? [],
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

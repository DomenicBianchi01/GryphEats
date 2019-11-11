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
            }.padding(.top, 50)
            
            SlideOverCard(handleText: "Pull Up To Customize") {
                VStack(alignment: .leading) {
                    ActionButton(text: "Add To Order") {
                        self.cart.items.append(self.item)
                        self.dismiss()
                    }.padding(.bottom, 30)
                    
                    Text("Ingredients").bold().padding(.leading)
                    
                    CheckBoxView(ingredients: [
                        Ingredient(id: 0, name: "Tomato"),
                        Ingredient(id: 1, name: "Lettuce"),
                        Ingredient(id: 2, name: "Onion"),
                        Ingredient(id: 3, name: "Pepper"),
                        Ingredient(id: 4, name: "Black Olives"),
                        Ingredient(id: 5, name: "Tomato"),
                        Ingredient(id: 6, name: "Lettuce"),
                        Ingredient(id: 7, name: "Onion"),
                        Ingredient(id: 8, name: "Pepper"),
                        Ingredient(id: 9, name: "Black Olives"),
                    ], onTap: { /*TODO*/ })
                }
            }
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: Private
    
    @EnvironmentObject private var cart: Cart
    
    private let item: RestaurantFoodItem
    
}

struct ItemOverview_Previews: PreviewProvider {
    
    static var previews: some View {
        ItemOverview(
            item: RestaurantFoodItem(
                foodItem: GraphFoodItem(id: "1", name: "Hamburger 1", price: 2),
                restaurantId: "1",
                restaurantName: "100 Mile Grill"))
            .environmentObject(Cart(items: []))
    }
}

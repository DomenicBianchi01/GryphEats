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
    
    var ingredients: [Ingredient]
    var onTap: () -> Void
    
    // MARK: Lifecycle
    
    init(ingredients: [Ingredient], onTap: @escaping () -> Void) {
        self.ingredients = ingredients
        self.onTap = onTap
    }
    
    // MARK: Internal
    
    var body: some View {
        content
    }
    
    // MARK: Private
    
    private var content: AnyView {
        
        return AnyView( List{
            ForEach(ingredients) { ingredient in
                CheckBoxRow(itemName: ingredient.name, onTap: self.onTap)
            }
        })
        
    }
    
}

//struct SliderView_Previews: PreviewProvider {
//    static var previews: some View {
//        VStack {
//            SliderView(
//                type: .foodItems([
//                    RestaurantFoodItem(
//                        foodItem: GraphFoodItem(id: "1", displayName: "Hamburger 1", price: 2),
//                        restaurantId: "1",
//                        restaurantName: "100 Mile Grill"),
//                    RestaurantFoodItem(
//                        foodItem: GraphFoodItem(id: "2", displayName: "Hamburger 2", price: 2),
//                        restaurantId: "1",
//                        restaurantName: "100 Mile Grill"),
//                    RestaurantFoodItem(
//                        foodItem: GraphFoodItem(id: "3", displayName: "Hamburger 3", price: 2),
//                        restaurantId: "1",
//                        restaurantName: "100 Mile Grill"),
//                    RestaurantFoodItem(
//                        foodItem: GraphFoodItem(id: "4", displayName: "Hamburger 4", price: 2),
//                        restaurantId: "1",
//                        restaurantName: "100 Mile Grill"),
//                    RestaurantFoodItem(
//                        foodItem: GraphFoodItem(id: "5", displayName: "Hamburger 5", price: 2),
//                        restaurantId: "1",
//                        restaurantName: "100 Mile Grill")
//                ]),
//                onTap: { _ in print("Tapped") })
//            SliderView(
//                type: .categories([
//                    Category(id: 0, name: "Fish"),
//                    Category(id: 1, name: "Pasta"),
//                    Category(id: 2, name: "Pizza"),
//                    Category(id: 3, name: "Meat"),
//                    Category(id: 4, name: "Dessert")
//                ]),
//                onTap: { _ in print("Tapped") })
//            SliderView(
//                type: .ingredients([
//                    Ingredient(id: 0, name: "Tomato", imageName: "tomato"),
//                    Ingredient(id: 1, name: "Lettuce", imageName: "tomato"),
//                    Ingredient(id: 2, name: "Onion", imageName: "tomato"),
//                    Ingredient(id: 3, name: "Pepper", imageName: "tomato"),
//                    Ingredient(id: 4, name: "Black Olives", imageName: "tomato"),
//                ]),
//                onTap: { _ in print("Tapped") })
//        }
//    }
//}

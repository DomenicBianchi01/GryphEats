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
    
    init(foodItem: FoodItem) {
        self.foodItem = foodItem
    }
    
    // MARK: Internal
    
    var body: some View {
        ZStack(alignment: .top) {
            GeometryReader { geometry in
                Image(self.foodItem.imageName)
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.vertical)
                    .frame(
                        maxWidth: geometry.size.width,
                        maxHeight: geometry.size.height)
            }
            
            HStack {
                VStack(alignment: .leading) {
                    Text(foodItem.name)
                        .foregroundColor(.white)
                        .font(.largeTitle)
                        .bold()
                    Text(self.foodItem.price.asDollarString)
                        .foregroundColor(.guelphYellow)
                        .fontWeight(.semibold)
                }.padding(.leading, 20)
                Spacer()
            }.padding(.top, 30)
            
            SlideOverCard(handleText: "Pull Up To Customize") {
                VStack(alignment: .leading) {
                    ActionButton(text: "Add To Order") {
                        self.cart.items.append(self.foodItem)
                        self.dismiss()
                    }.padding(.bottom, 30)
                    
                    Text("Ingredients").bold().padding(.leading)
                    
                    ScrollView {
                        SliderView(
                            type: .ingredients([
                                Ingredient(id: 0, name: "Tomato", imageName: "tomato"),
                                Ingredient(id: 1, name: "Lettuce", imageName: "tomato"),
                                Ingredient(id: 2, name: "Onion", imageName: "tomato"),
                                Ingredient(id: 3, name: "Pepper", imageName: "tomato"),
                                Ingredient(id: 4, name: "Black Olives", imageName: "tomato"),
                            ])) { _ in }
                    }
                    
                    // SwiftUI Bug: The code below should work in theory (only make the content scrollable if needed).
                    // However, if the else block is executed the app crashes for some reason...
                    
                    //                    GeometryReader { proxy in
                    //                        if proxy.size.height > UIScreen.main.bounds.height - 190 {
                    //                            ScrollView {
                    //                                SliderView(
                    //                                    type: .ingredients([
                    //                                        Ingredient(id: 0, name: "Tomato", imageName: "tomato"),
                    //                                        Ingredient(id: 1, name: "Lettuce", imageName: "tomato"),
                    //                                        Ingredient(id: 2, name: "Onion", imageName: "tomato"),
                    //                                        Ingredient(id: 3, name: "Pepper", imageName: "tomato"),
                    //                                        Ingredient(id: 4, name: "Black Olives", imageName: "tomato"),
                    //                                    ])) { _ in }
                    //                            }
                    //                        } else {
                    //                            SliderView(
                    //                                type: .ingredients([
                    //                                    Ingredient(id: 0, name: "Tomato", imageName: "tomato"),
                    //                                    Ingredient(id: 1, name: "Lettuce", imageName: "tomato"),
                    //                                    Ingredient(id: 2, name: "Onion", imageName: "tomato"),
                    //                                    Ingredient(id: 3, name: "Pepper", imageName: "tomato"),
                    //                                    Ingredient(id: 4, name: "Black Olives", imageName: "tomato"),
                    //                                ])) { _ in }
                    //                            Spacer()
                    //                        }
                    //                    }
                }
            }
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: Private
    
    @EnvironmentObject private var cart: Cart
    
    private let foodItem: FoodItem
    
}

struct ItemOverview_Previews: PreviewProvider {
    
    static var previews: some View {
        ItemOverview(foodItem: FoodItem(id: 0, name: "Cheese Hamburger", imageName: "hamburger"))
            .environmentObject(Cart(items: []))
    }
}

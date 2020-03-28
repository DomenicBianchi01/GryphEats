//
//  SliderView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-07.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - SliderView

struct SliderView: View {
    
    // MARK: SliderType
    
    enum SliderType {
        case foodItems([RestaurantFoodItem])
    }
    
    // MARK: Lifecycle
    
    init(type: SliderType, onTap: @escaping (RestaurantFoodItem) -> Void) {
        self.type = type
        self.onTap = onTap
    }
    
    // MARK: Internal
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: -5) {
                sliderContent
            }
        }
    }
    
    // MARK: Private
    
    private let type: SliderType
    private let onTap: (RestaurantFoodItem) -> Void
    
    private var sliderContent: some View {
        switch type {
        case .foodItems(let items):
            return ForEach(items.indices, id: \.self) { index in
                self.menuCard(for: items[index], atIndex: index, onTap: { _ in
                    self.onTap(items[index])
                })
            }
        }
    }
    
    private func menuCard(for item: RestaurantFoodItem, atIndex index: Int, onTap: @escaping (Int) -> Void) -> AnyView {
        let card = MenuCard(itemName: item.foodItem.name, imageUrl: item.imageURL ?? "") {
            onTap(index)
        }
        
        if index == 0 {
            // Give some extra leading padding to the first card
            return AnyView(card.padding(.leading, 10))
        } else {
            return AnyView(card)
        }
    }
}

struct SliderView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            SliderView(
                type: .foodItems([
                    RestaurantFoodItem(
                        foodItem: FoodItemDetails(id: "1", name: "Hamburger 1", price: 2, inStock: true),
                        restaurantId: "1",
                        restaurantName: "100 Mile Grill"),
                    RestaurantFoodItem(
                        foodItem: FoodItemDetails(id: "2", name: "Hamburger 2", price: 2, inStock: true),
                        restaurantId: "1",
                        restaurantName: "100 Mile Grill"),
                    RestaurantFoodItem(
                        foodItem: FoodItemDetails(id: "3", name: "Hamburger 3", price: 2, inStock: true),
                        restaurantId: "1",
                        restaurantName: "100 Mile Grill"),
                    RestaurantFoodItem(
                        foodItem: FoodItemDetails(id: "4", name: "Hamburger 4", price: 2, inStock: true),
                        restaurantId: "1",
                        restaurantName: "100 Mile Grill"),
                    RestaurantFoodItem(
                        foodItem: FoodItemDetails(id: "5", name: "Hamburger 5", price: 2, inStock: true),
                        restaurantId: "1",
                        restaurantName: "100 Mile Grill")
                ]),
                onTap: { _ in })
        }
    }
}

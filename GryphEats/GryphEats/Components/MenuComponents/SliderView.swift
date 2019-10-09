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
        case categories([Category])
        case foodItems([FoodItem])
    }
    
    // MARK: Lifecycle
    
    init(type: SliderType, onTap: @escaping (Int) -> Void) {
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
    private let onTap: (Int) -> Void
    
    private var sliderContent: AnyView {
        switch type {
        case .categories(let categories):
            return AnyView(ForEach(categories.indices) { index in
                CategoryCard(name: categories[index].name) {
                    self.onTap(index)
                }
            })
        case .foodItems(let items):
            return AnyView(ForEach(items.indices) { index in
                self.menuCard(for: items[index], atIndex: index, onTap: self.onTap)
            })
        }
    }
    
    private func menuCard(for item: FoodItem, atIndex index: Int, onTap: @escaping (Int) -> Void) -> AnyView {
        let card = MenuCard(itemName: item.name, imageName: item.image) {
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
                    FoodItem(id: 0, name: "Hamburger 1", image: "hamburger"),
                    FoodItem(id: 1, name: "Hamburger 2", image: "hamburger"),
                    FoodItem(id: 2, name: "Hamburger 3", image: "hamburger"),
                    FoodItem(id: 3, name: "Hamburger 4", image: "hamburger"),
                    FoodItem(id: 4, name: "Hamburger 5", image: "hamburger")
                ]),
                onTap: { _ in print("Tapped") })
            SliderView(
                type: .categories([
                    Category(id: 0, name: "Fish"),
                    Category(id: 1, name: "Pasta"),
                    Category(id: 2, name: "Pizza"),
                    Category(id: 3, name: "Meat"),
                    Category(id: 4, name: "Dessert")
                ]),
                onTap: { _ in print("Tapped") })
        }
    }
}

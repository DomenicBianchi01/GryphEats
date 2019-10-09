//
//  HomeViewModel.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-08.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Foundation

// MARK: - HomeViewModel

class HomeViewModel {
    
    // MARK: Internal
    
    let categories: [Category] = [
        Category(id: 0, name: "Fish"),
        Category(id: 1, name: "Pasta"),
        Category(id: 2, name: "Pizza"),
        Category(id: 3, name: "Meat"),
        Category(id: 4, name: "Desert")
    ]
    
    let resutrants: [Resturant] = [
        Resturant(id: 0, name: "100 Mile Grill", foodItems: foodItems),
        Resturant(id: 1, name: "Mom's Kitchen", foodItems: foodItems),
        Resturant(id: 2, name: "Nature's Best", foodItems: foodItems)
    ]
    
    // MARK: Private
    
    private static let foodItems: [FoodItem] = [
        FoodItem(id: 0, name: "Hamburger 1", image: "hamburger"),
        FoodItem(id: 1, name: "Hamburger 2", image: "hamburger"),
        FoodItem(id: 2, name: "Hamburger 3", image: "hamburger"),
        FoodItem(id: 3, name: "Hamburger 4", image: "hamburger"),
        FoodItem(id: 4, name: "Hamburger 5", image: "hamburger")
    ]
}

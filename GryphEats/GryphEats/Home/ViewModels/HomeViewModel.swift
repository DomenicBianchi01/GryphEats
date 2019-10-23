//
//  HomeViewModel.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-08.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - HomeViewModel

class HomeViewModel: ObservableObject {
    
    // MARK: LoadingState
    
    enum LoadingState {
        case loading
        case loaded([Restaurant])
        case error
    }
    
    // MARK: Internal
    
    let categories: [Category] = [
        Category(id: 0, name: "Fish"),
        Category(id: 1, name: "Pasta"),
        Category(id: 2, name: "Pizza"),
        Category(id: 3, name: "Meat"),
        Category(id: 4, name: "Desert")
    ]
    
    @Published var loadingState: LoadingState = .loading
    
    // MARK: Private
    
    private let foodItems: [FoodItem] = [
        FoodItem(id: 0, name: "Hamburger 1", imageName: "hamburger"),
        FoodItem(id: 1, name: "Hamburger 2", imageName: "hamburger"),
        FoodItem(id: 2, name: "Hamburger 3", imageName: "hamburger"),
        FoodItem(id: 3, name: "Hamburger 4", imageName: "hamburger"),
        FoodItem(id: 4, name: "Hamburger 5", imageName: "hamburger")
    ]
    
    func fetchRestaurants() {
        self.loadingState = .loading
        
        self.loadingState = .loaded([
            Restaurant(id: "0", name: "Moms", foodItems: self.foodItems),
            Restaurant(id: "0", name: "Moms", foodItems: self.foodItems),
            Restaurant(id: "0", name: "Moms", foodItems: self.foodItems),
            Restaurant(id: "0", name: "Moms", foodItems: self.foodItems)
        ])
        
//        Apollo.shared.fetch(query: RestaurantsQuery()) { result in
//            switch result {
//            case .success(let data):
//                var restaurants: [Restaurant] = []
//
//                for restaurant in data.restaurants.compactMap({ $0 }) {
//                    restaurants.append(Restaurant(
//                        id: restaurant.restaurantid,
//                        name: restaurant.displayname,
//                        foodItems: self.foodItems))
//                }
//
//                self.loadingState = .loaded(restaurants)
//            case .failure:
//                self.loadingState = .error
//            }
//        }
    }
}

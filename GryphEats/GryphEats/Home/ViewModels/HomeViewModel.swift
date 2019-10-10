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
        case loaded([Resturant])
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
    
    func fetchResturants() {
        self.loadingState = .loading
        
        Apollo.shared.fetch(query: ResturantsQuery()) { result in
            switch result {
            case .success:
                //TODO: Use real data from `result`
                self.loadingState = .loaded([
                    Resturant(id: 0, name: "100 Mile Grill", foodItems: self.foodItems),
                    Resturant(id: 1, name: "Mom's Kitchen", foodItems: self.foodItems),
                    Resturant(id: 2, name: "Nature's Best", foodItems: self.foodItems)
                ])
            case .failure:
                self.loadingState = .error
            }
        }
    }
}

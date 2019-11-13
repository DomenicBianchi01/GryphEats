//
//  HomeViewModel.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-08.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Apollo
import SwiftUI

// MARK: - HomeViewModel

class HomeViewModel: ObservableObject {
    
    // MARK: Internal
    
    @Published private(set) var loadingState: LoadingState<[GraphRestaurant]> = .loading
    
    let categories: [Category] = [
        Category(id: 0, name: "Fish"),
        Category(id: 1, name: "Pasta"),
        Category(id: 2, name: "Pizza"),
        Category(id: 3, name: "Meat"),
        Category(id: 4, name: "Desert")
    ]
    
    func fetchRestaurants() {
        self.loadingState = .loading
        
        GraphClient.shared.fetch(query: RestaurantMenusQuery()) { result in
            switch result {
            case .success(let data):
                self.allRestaurantData = data.restaurants.compactMap({ $0 })
                self.loadingState = .loaded(self.allRestaurantData)
            case .failure:
                self.loadingState = .error
            }
        }
    }
    
    func filterRestaurants(by searchText: String) {
        if searchText.isEmpty {
            loadingState = .loaded(allRestaurantData)
            return
        }
        
        let filteredRestaurants: [GraphRestaurant] = allRestaurantData.compactMap {
            guard let items = $0.menu.first(where: { $0?.isActive == true })??.menuItems.compactMap({ $0 }) else {
                return nil
            }
            
            return GraphRestaurant(
                id: $0.id,
                name: $0.name,
                menu: [
                    RestaurantMenusQuery.Data.Restaurant.Menu(
                        isActive: true,
                        menuItems: items.filter {
                            $0.item.fragments.foodItemDetails.name.lowercased().contains(searchText.lowercased())
                        }
                    )
                ]
            )
        }
        
        loadingState = .loaded(filteredRestaurants.filter { !($0.menu.first??.menuItems.isEmpty ?? true) })
    }
    
    // MARK: Private
    
    private var allRestaurantData: [GraphRestaurant] = []
    
}

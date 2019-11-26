//
//  RestStationsViewModel.swift
//  GryphEats
//
//  Created by Matthew Bebis on 10/23/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - RestStationsViewModel

class RestStationsViewModel: ObservableObject {
    
    // MARK: Internal
    
    @Published private(set) var loadingState: LoadingState<[Restaurant]> = .loading
    
    // MARK: Private
    
    func fetchRestaurants() {
        self.loadingState = .loading
        
        GraphClient.shared.fetch(query: RestaurantMenusQuery()) { result in
            switch result {
            case .success(let data):
                var restaurants: [Restaurant] = []

                for restaurant in data.restaurants.compactMap({ $0 }) {
                    restaurants.append(Restaurant(
                        id: restaurant.fragments.restaurantDetails.id,
                        name: restaurant.fragments.restaurantDetails.name,
                        isOpen: restaurant.fragments.restaurantDetails.isActive,
                        foodItems: []))
                }

                self.loadingState = .loaded(restaurants)
            case .failure:
                self.loadingState = .error
            }
        }
    }
}

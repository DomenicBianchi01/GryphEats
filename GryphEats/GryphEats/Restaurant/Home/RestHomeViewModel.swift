//
//  RestHomeViewModel.swift
//  GryphEats
//
//  Created by Matthew Bebis on 10/23/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - RestHomeViewModel

class RestHomeViewModel: ObservableObject {
    
    // MARK: LoadingState
    
    enum LoadingState {
        case loading
        case loaded([Restaurant])
        case error
    }
    
    @Published var loadingState: LoadingState = .loading
    
    // MARK: Private
    
    func fetchRestaurants() {
        self.loadingState = .loading

//        self.loadingState = .loaded([Restaurant(id: "0", name: "Moms", foodItems: [])])

        GraphClient.shared.fetch(query: RestaurantMenusQuery()) { result in
            switch result {
            case .success(let data):
                var restaurants: [Restaurant] = []

                for restaurant in data.restaurants.compactMap({ $0 }) {
                    restaurants.append(Restaurant(
                        id: restaurant.id,
                        name: restaurant.name,
                        foodItems: []))
                }

                self.loadingState = .loaded(restaurants)
            case .failure:
                self.loadingState = .error
            }
        }
    }
}

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
                self.loadingState = .loaded(data.restaurants.compactMap({ $0 }))
            case .failure:
                self.loadingState = .error
            }
        }
    }
}

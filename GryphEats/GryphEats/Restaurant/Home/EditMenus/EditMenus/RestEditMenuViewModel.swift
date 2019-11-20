//
//  RestEditMenuModel.swift
//  GryphEats
//
//  Created by Owner on 11/9/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

class RestEditMenuViewModel: ObservableObject {
    // MARK: Internal
    
    enum UpdateFoodError: Error, LocalizedError {
        case updateAvailableError
        case updatePriceError
        
        // MARK: Internal
        
        var recoverySuggestion: String? {
            switch self {
            case .updateAvailableError:
                return "This Food item availability could not be updated."
            case .updatePriceError:
                return "This Food item price could not be updated."
            }
        }
        
        var errorDescription: String? {
            "Error"
        }
    }
    
    @Published var loadingState: LoadingState<Restaurant> = .loading
    private var restID: String
    
    init(restID: String) {
        self.restID = restID
    }
    
    // MARK: Private
    
    func fetchMenus() {
        self.loadingState = .loading
        
        GraphClient.shared.fetch(query: MenusByRestQuery(restID: restID)) { result in
            switch result {
            case .success(let data):
                self.loadingState = .loading

                var restaurantMenu: Restaurant = Restaurant(id: "", name: "", isOpen: true, foodItems: [])
                var foodItems: [GraphFoodItem] = []
                                
                for menu in data.getMenusByRestaurantId.compactMap({ $0 }) {
                    for menuItem in menu.menuItems {
                        let foodItem = menuItem?.item.fragments.foodItemDetails
                        foodItems.append(GraphFoodItem(id: foodItem!.id, name: foodItem!.name, price: foodItem!.price, isavailable: foodItem!.isavailable))
                    }
                    restaurantMenu = Restaurant(id: menu.restaurant.fragments.restaurantDetails.id, name: menu.restaurant.fragments.restaurantDetails.name, isOpen: menu.restaurant.fragments.restaurantDetails.isOpen, foodItems: foodItems)
                }
                self.loadingState = .loaded(restaurantMenu)
            case .failure:
                self.loadingState = .error
            }
        }
    }
    
    func ninjaFetchMenus() {
//        self.loadingState = .loading
        
        GraphClient.shared.fetch(query: MenusByRestQuery(restID: restID)) { result in
            switch result {
            case .success(let data):
//                self.loadingState = .loading

                var restaurant: Restaurant = Restaurant(id: "", name: "", isOpen: true, foodItems: [])
                var foodItems: [GraphFoodItem] = []
                                
                for menu in data.getMenusByRestaurantId.compactMap({ $0 }) {
                    for menuItem in menu.menuItems {
                        let foodItem = menuItem?.item.fragments.foodItemDetails
                        foodItems.append(GraphFoodItem(id: foodItem!.id, name: foodItem!.name, price: foodItem!.price, isavailable: foodItem!.isavailable))
                    }
                    restaurant = Restaurant(id: menu.restaurant.fragments.restaurantDetails.id, name: menu.restaurant.fragments.restaurantDetails.name, isOpen: menu.restaurant.fragments.restaurantDetails.isOpen, foodItems: foodItems)
                }
                self.loadingState = .loaded(restaurant)
            case .failure:
                self.loadingState = .error
            }
        }
    }
    
    func mutateFoodAvailability(foodID: String, isAvailable: String) {
        GraphClient.shared.perform(mutation: UpdateFoodAvailableMutation(foodID: foodID, isAvailable: isAvailable)) { result in
            switch result {
            case .success(let data):
                print(data.didUpdate ?? false)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func mutateFoodPrice(foodID: String, price: String) {
        GraphClient.shared.perform(mutation: UpdateFoodPriceMutation(foodID: foodID, price: price)) { result in
            switch result {
            case .success(let data):
                print(data.didUpdate ?? false)
                
            case .failure(let error):
                print(error)
            }
        }
    }
    
    func mutateRestaurantActive(restID: String, isActive: Bool) {
        GraphClient.shared.perform(mutation: UpdateRestaurantActiveMutation(restaurantID: restID, isActive: isActive)) { result in
            switch result {
            case .success(let data):
                print(data.didUpdate ?? false)
            case .failure(let error):
                print(error)
            }
        }
    }

}

//
//  HomeViewModel.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-08.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Apollo
import SwiftUI
import AWSTranslate

// MARK: - HomeViewModel

class HomeViewModel: ObservableObject {
    
    // MARK: Internal
    
    @Published private(set) var loadingState: LoadingState<[RestaurantDetails]> = .loading
    
    /// Use this to determine if there is at least one restaurant that is open
    var restaurantsAreOpen: Bool {
        !allRestaurantData.isEmpty
    }
    
    func fetchRestaurants() {
        self.loadingState = .loading
        
        GraphClient.shared.fetch(query: RestaurantMenusQuery()) { result in
            switch result {
            case .success(let data):
                self.parseRestaurantDetails(data.restaurants.compactMap({ $0?.fragments.restaurantDetails }))
            case .failure:
                self.loadingState = .error
            }
        }
        
        menuSubscription?.cancel()
        
        menuSubscription = GraphClient.shared.subscribe(subscription: MenusUpdatedSubscription()) { result in
            switch result {
            case .success(let data):
                self.parseRestaurantDetails(data.menuUpdated.compactMap({ $0?.fragments.restaurantDetails }))
            case .failure:
                self.loadingState = .error
            }
        }
    }
    
    func cancelSubscription() {
        menuSubscription?.cancel()
        menuSubscription = nil
    }
    
    func filterRestaurants(by searchText: String) {
        if searchText.isEmpty {
            loadingState = .loaded(filterInStockOnly())
            return
        }
        
        let filteredRestaurants: [RestaurantDetails] = filterInStockOnly().compactMap {
            guard let items = $0.menu.first(where: { $0?.isActive == true })??.menuItems.compactMap({ $0 }) else {
                return nil
            }
            
            return RestaurantDetails(
                id: $0.id,
                name: $0.name,
                isActive: $0.isActive,
                menu: [
                    RestaurantDetails.Menu(
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
    
    private var allRestaurantData: [RestaurantDetails] = []
    private var menuSubscription: Cancellable? = nil
    
    private func filterInStockOnly() -> [RestaurantDetails] {
        
        //AWS Translate
        AWSServiceManager.default().defaultServiceConfiguration = configuration
        
        let translateClient = AWSTranslate.default()
        let translateRequest = AWSTranslateTranslateTextRequest()
        translateRequest?.sourceLanguageCode = "en"
        translateRequest?.targetLanguageCode = Locale.current.languageCode
        
        //AWS Translate
        
        return allRestaurantData.compactMap { restaurant in
            guard let items = restaurant.menu.first(where: { $0?.isActive == true })??.menuItems.compactMap({ $0 }) else {
                return nil
            }
            
            var menuItems: [RestaurantDetails.Menu.MenuItem] = items
            
            if (Locale.current.languageCode != "en") {
                
                let myGroup = DispatchGroup()
                
                menuItems = []
                
                items.forEach({ item in
                    let ingredientGroup = DispatchGroup()
                    //
                    var translatedIngredients: [FoodItemDetails.Ingredient] = []
                    item.item.fragments.foodItemDetails.ingredients?.forEach({ ingredient in
                        ingredientGroup.enter()
                        let translatedIngredient = FoodItemDetails.Ingredient(id: ingredient.id, name: ingredient.name.translateText())
                                translatedIngredients.append(translatedIngredient)
                            ingredientGroup.leave()
                    })

                    ingredientGroup.wait()
                    ingredientGroup.notify(queue: .main) {
                        print("ingredients done")
                    }
                    myGroup.enter()
                    
                    var menuItemX: RestaurantDetails.Menu.MenuItem = RestaurantDetails.Menu.MenuItem(item: item.item)
                    
                    translateRequest?.text = item.item.fragments.foodItemDetails.name

                    let translatedItem = FoodItemDetails(id: item.item.fragments.foodItemDetails.id, name: item.item.fragments.foodItemDetails.name.translateText(), price: item.item.fragments.foodItemDetails.price, inStock: item.item.fragments.foodItemDetails.inStock, ingredients: translatedIngredients)
                            menuItemX.item.fragments.foodItemDetails = translatedItem
                            menuItems.append(menuItemX)

                        myGroup.leave()

                })
                myGroup.wait()
                
                myGroup.notify(queue: .main) {
                    print("Finished all requests.")
                }
                
            }
            
            return RestaurantDetails(
                id: restaurant.id,
                name: restaurant.name,
                isActive: restaurant.isActive,
                menu: [
                    RestaurantDetails.Menu(
                        isActive: true,
                        menuItems: menuItems.filter {
                            $0.item.fragments.foodItemDetails.inStock
                        }
                    )
                ]
            )
        }
    }
    
    private func parseRestaurantDetails(_ data: [RestaurantDetails]) {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm:ss"
        
        let dateString = dateFormatter.string(from: Date())
        let currentDate = dateFormatter.date(from: dateString)
        
        self.allRestaurantData = data.filter {
            guard $0.isActive,
                let currentDate = currentDate,
                let openingTime = dateFormatter.date(from: $0.openingTime ?? ""),
                let closingTime = dateFormatter.date(from: $0.closingTime ?? "") else {
                    return false
            }
            
            return currentDate.compare(openingTime) == .orderedDescending &&
                currentDate.compare(closingTime) == .orderedAscending
        }
        
        self.loadingState = .loaded(self.filterInStockOnly())
    }
}

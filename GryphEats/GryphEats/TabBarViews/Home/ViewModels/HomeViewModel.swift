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

var credentialsProvider = AWSStaticCredentialsProvider(accessKey: AWSKeys.accessKey, secretKey: AWSKeys.secretKey)
var configuration = AWSServiceConfiguration(region: AWSRegionType.USEast1, credentialsProvider: credentialsProvider)

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
                
        let callback: (AWSTranslateTranslateTextResponse?, Error?) -> Void = { (response, error) in
           guard let response = response else {
              print("Got error \(error)")
              return
           }
                    
           if let translatedText = response.translatedText {
              print (translatedText)
           }
        }
        //AWS Translate
                        
        return allRestaurantData.compactMap { restaurant in
            guard let items = restaurant.menu.first(where: { $0?.isActive == true })??.menuItems.compactMap({ $0 }) else {
                return nil
            }

            items.forEach({ item in
                translateRequest?.text = item.item.fragments.foodItemDetails.name
                translateClient.translateText(translateRequest!, completionHandler: callback)
//                print(item.item.fragments.foodItemDetails.name)
            })
            
            return RestaurantDetails(
                id: restaurant.id,
                name: restaurant.name,
                isActive: restaurant.isActive,
                menu: [
                    RestaurantDetails.Menu(
                        isActive: true,
                        menuItems: items.filter {
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

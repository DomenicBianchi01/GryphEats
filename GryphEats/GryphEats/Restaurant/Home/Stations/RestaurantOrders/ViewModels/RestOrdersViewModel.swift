//
//  RestOrdersViewModel.swift
//  GryphEats
//
//  Created by Matthew Bebis on 10/23/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Apollo
import SwiftUI

// MARK: - RestOrdersViewModel

class RestOrdersViewModel: ObservableObject {
    
    // MARK: Lifecycle
    
    init(restID: String) {
        self.restID = restID
    }
    
    deinit {
        cancelSubscription()
    }
    
    // MARK: Internal
    
    @Published private(set) var loadingState: LoadingState<[Order]> = .loading
    var restID: String
    
    func fetchOrders() {
        loadingState = .loading
        
        GraphClient.shared.fetch(query: OrdersByRestQuery(restID: restID)) { result in
            switch result {
            case .success(let data):
                
                var orders: [Order] = []
                
                for order in data.getOrdersByRestaurantId.compactMap({ $0 }) {
                    var foodItems: [RestaurantFoodItem] = []
                    for orderItem in (order.orderitems.compactMap({ $0 })) {
                        var itemIngredients: [FoodItemDetails.Ingredient] = []
                        for ingredient in ((orderItem.item.fragments.foodItemDetails.ingredients?.compactMap({ $0 }))!) {
                            itemIngredients.append(FoodItemDetails.Ingredient( id: ingredient.id, name: ingredient.name ))
                        }
                        foodItems.append(RestaurantFoodItem(
                            foodItem: GraphFoodItem(
                                id: orderItem.foodid,
                                name: orderItem.item.fragments.foodItemDetails.name,
                                price: orderItem.item.fragments.foodItemDetails.price,
                                inStock: orderItem.item.fragments.foodItemDetails.inStock,
                                ingredients: itemIngredients),
                            restaurantId: order.restaurantid,
                            restaurantName: "TODO?"))
                    }
                    orders.append(Order(
                        id: order.orderid,
                        restaurantID: order.restaurantid,
                        customer: Customer(name: "John Doe"),
                        status: order.ordertype,
                        timePlaced: order.timeplaced,
                        specialInstructions: order.instructions,
                        items: foodItems
                    ))
                }
                self.loadingState = .loaded(orders)
            case .failure:
                self.loadingState = .error
            }
        }
        
        subscription = GraphClient.shared.subscribe(
            subscription: OrderUpdatedSubscription(restaurantID: restID))
        { result in
            switch result {
            case .success(let data):
                
                guard let orders2 = data.orderUpdated?.compactMap({ $0 }) else {
                    self.loadingState = .error
                    return
                }
                
                var orders: [Order] = []
                
                for order in orders2.compactMap({ $0 }) {
                    var foodItems: [RestaurantFoodItem] = []
                    for orderItem in (order.orderitems.compactMap({ $0 })) {
                        var itemIngredients: [FoodItemDetails.Ingredient] = []
                        for ingredient in ((orderItem.item.fragments.foodItemDetails.ingredients?.compactMap({ $0 }))!) {
                            itemIngredients.append(FoodItemDetails.Ingredient( id: ingredient.id, name: ingredient.name ))
                        }
                        foodItems.append(RestaurantFoodItem(
                            foodItem: GraphFoodItem(
                                id: orderItem.foodid,
                                name: orderItem.item.fragments.foodItemDetails.name,
                                price: orderItem.item.fragments.foodItemDetails.price,
                                inStock: orderItem.item.fragments.foodItemDetails.inStock,
                                ingredients: itemIngredients),
                            restaurantId: order.restaurantid,
                            restaurantName: "TODO?"))
                    }

                    orders.append(Order(
                        id: order.orderid,
                        restaurantID: order.restaurantid,
                        customer: Customer(name: "John Doe"),
                        status: order.ordertype,
                        timePlaced: order.timeplaced,
                        items: foodItems
                    ))
                }
                
                self.loadingState = .loaded(orders)
            case .failure:
                self.loadingState = .error
            }
        }
    }
    
    func cancelSubscription() {
        subscription?.cancel()
        subscription = nil
    }
    
    // MARK: Private
    
    private var subscription: Cancellable?
    
}

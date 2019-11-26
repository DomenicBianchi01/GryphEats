//
//  OrdersViewModel.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-11-01.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Foundation

// MARK: - OrdersViewModel

class OrdersViewModel: ObservableObject {
    
    // MARK: Internal
    
    @Published private(set) var loadingState: LoadingState<[Order]> = .loading
    
    func fetchOrders(userID: String) {
        loadingState = .loading
        
        GraphClient.shared.fetch(query: UserOrdersQuery(userID: userID)) { result in
            switch result {
            case .success(let data):
                self.loadingState = .loaded(data.getOrdersByUserId.compactMap({ $0 }).map { order in
                    Order(
                        id: order.id,
                        restaurantName: order.restaurantName,
                        restaurantID: order.restaurantId,
                        customer: Customer(name: ""),
                        status: order.status,
                        timePlaced: order.timePlaced,
                        estimatedTimeRemaining: order.estimatedTimeRemaining,
                        paymentType: order.paymentType,
                        specialInstructions: order.instructions,
                        items: order.items.map { item in
                            RestaurantFoodItem(
                                foodItem: item.item.fragments.foodItemDetails,
                                selectedIngredients: item.ingredientsWrapper?.compactMap {
                                    guard let ingredient = $0.fragments.toppings.ingredient else {
                                        return nil
                                    }
                                    
                                    return GraphFoodItem.Ingredient(id: ingredient.id, name: ingredient.name)
                                    } ?? [],
                                restaurantId: order.restaurantId,
                                restaurantName: "") // TODO: Need restaurant name
                    })
                })
            case .failure:
                self.loadingState = .error
            }
        }
    }
}

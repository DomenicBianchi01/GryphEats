//
//  OrderSubmission.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-11-11.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Foundation

// MARK: - OrderSubmission

class OrderSubmission: NSObject {
    
    // MARK: OrderSubmissionError
    
    enum OrderSubmissionError: Error, LocalizedError {
        case invalidCart
        case paymentDeclined
        
        // MARK: Internal
        
        var recoverySuggestion: String? {
            switch self {
            case .invalidCart:
                return "We could not submit your order. Please try again later."
            case .paymentDeclined:
                return "Please check that your payment details are correct"
            }
        }
        
        var errorDescription: String? {
            switch self {
            case .invalidCart:
                return "Error"
            case .paymentDeclined:
                return "Payment Declined"
            }
        }
    }
    
    // MARK: OrderSubmissionResult
    
    struct OrderSubmissionResult {
        
        // MARK: Internal
        
        let success: Bool
        let numberOfOrders: Int
        
    }
    
    func submitOrder(
        for userID: String,
        with cart: Cart,
        using paymentMethod: PaymentType,
        completion: @escaping (Result<OrderSubmissionResult, OrderSubmissionError>) -> Void)
    {
        // If an order has items from different restaurants, we need to split the order into "one order per restaurant"
        var splitItems: [String: [RestaurantFoodItem]] = [:]
        
        cart.items.forEach { item in
            if splitItems[item.restaurantId] != nil {
                splitItems[item.restaurantId]?.append(item)
            } else {
                splitItems[item.restaurantId] = [item]
            }
        }
        
        let dispatchGroup = DispatchGroup()
        var placedOrder = true
        
        splitItems.forEach { element in
            dispatchGroup.enter()
            GraphClient.shared.perform(
                mutation: PlaceOrderMutation(
                    items: element.value.compactMap {
                        FoodWrapper(foodid: $0.foodItem.id, toppingids: $0.selectedIngredients.compactMap { $0.id })
                    },
                    restaurantID: element.key,
                    userID: userID,
                    instructions: cart.specialInstructions,
                    paymentMethod: paymentMethod))
            { result in
                dispatchGroup.leave()
                switch result {
                case .success:
                    break
                case .failure:
                    placedOrder = false
                }
            }
        }
        
        dispatchGroup.notify(queue: .main) {
            //TODO: If an order fails, cancel all the previous ones just placed
            completion(.success(OrderSubmissionResult(success: placedOrder, numberOfOrders: splitItems.count)))
        }
    }
}

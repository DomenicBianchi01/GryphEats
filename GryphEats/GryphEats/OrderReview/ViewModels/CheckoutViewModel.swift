//
//  CheckoutViewModel.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-16.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Apollo
import Foundation
import Valet

// MARK: - CheckoutViewModel

class CheckoutViewModel {
    
    // MARK: CheckoutError
    
    enum CheckoutError: Error, LocalizedError {
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
    
    // MARK: Internal
    
    var paymentMethods: [PaymentMethod] {
        guard let rawData = Valet.keychain.string(forKey: Valet.Key.paymentMethods.rawValue),
            let paymentMethods = try? JSONDecoder().decode([PaymentMethod].self, from: Data(rawData.utf8)) else {
                return []
        }
        
        return paymentMethods
    }
    
    func submitOrder(for userID: String, with cart: Cart, completion: @escaping (Result<Bool, CheckoutError>) -> Void) {
        // If an order has items from different restaurants, we need to split the order into "one order per restaurant"
        var splitItems: [String: [GraphFoodItem]] = [:]
        
        cart.items.forEach { item in
            if splitItems[item.restaurantId] != nil {
                splitItems[item.restaurantId]?.append(item.foodItem)
            } else {
                splitItems[item.restaurantId] = [item.foodItem]
            }
        }
        
        let dispatchGroup = DispatchGroup()
        var placedOrder = true
        
        splitItems.forEach { element in
            dispatchGroup.enter()
            // Something doesn't feel right having to use DispatchQueue...
            DispatchQueue.global(qos: .background).async {
                GraphClient.shared.perform(
                    mutation: PlaceOrderMutation(
                        foodIDs: element.value.compactMap { $0.id },
                        restaurantID: element.key,
                        userID: userID))
                { result in
                    dispatchGroup.leave()
                    switch result {
                    case .success:
                        break
                    case .failure:
                        placedOrder = false
                    }
                }
                
                dispatchGroup.wait()
            }
        }
        
        //TODO: If an order fails, cancel all the previous ones just placd
        completion(.success(placedOrder))
    }
}

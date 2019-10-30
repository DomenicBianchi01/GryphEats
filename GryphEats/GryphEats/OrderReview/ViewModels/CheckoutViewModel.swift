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
    
    // MARK: PaymentError
    
    enum PaymentError: Error, LocalizedError {
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
    
    func submitPayment(for cart: Cart, completion: @escaping (Result<Bool, PaymentError>) -> Void) {
        guard let restaurantID = cart.items.first?.restaurantId else {
            return completion(.failure(.invalidCart))
        }
        
        GraphClient.shared.perform(mutation: PlaceOrderMutation(foodIDs: cart.items.compactMap { $0.id }, restaurantID: restaurantID)) { result in
            switch result {
            case .success:
                return completion(.success(true))
            case .failure:
                return completion(.failure(.paymentDeclined))
            }
        }
    }
}

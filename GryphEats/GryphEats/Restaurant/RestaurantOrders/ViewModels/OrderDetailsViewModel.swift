//
//  OrderDetailsViewModel.swift
//  GryphEats
//
//  Created by Matthew Bebis on 10/23/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - OrderDetailsViewModel

class OrderDetailsViewModel: ObservableObject {
    
    enum OrderCompleteError: Error, LocalizedError {
        case failure
        
        // MARK: Internal
        
        var recoverySuggestion: String? {
            switch self {
            case .failure:
                return "We could not mark the order as complete. Please try again later."
            }
        }
        
        var errorDescription: String? {
            switch self {
            case .failure:
                return "Error"
            }
        }
    }
    
    func sendOrderComplete(orderID: String, completion: @escaping (Result<Bool, OrderCompleteError>) -> Void) {
        Apollo.shared.perform(mutation: CompleteOrderMutation(orderID: orderID)) { result in
            switch result {
            case .success:
                return completion(.success(true))
            case .failure:
                return completion(.failure(.failure))
            }
        }
    }
    
}

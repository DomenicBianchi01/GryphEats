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
    
    // MARK: OrderUpdateError
    
    enum OrderUpdateError: Error, LocalizedError {
        case failure
        
        // MARK: Internal
        
        var recoverySuggestion: String? {
            "We could not update the status of the order. Please try again later."
        }
        
        var errorDescription: String? {
            "Error"
        }
    }
    
    func update(
        order: Order,
        status: OrderStatus,
        completion: @escaping (Result<Bool, OrderUpdateError>) -> Void)
    {
        GraphClient.shared.perform(
            mutation: UpdateOrderMutation(orderID: order.id, status: status, restaurantID: order.restaurantID))
        { result in
            switch result {
            case .success:
                return completion(.success(true))
            case .failure:
                return completion(.failure(.failure))
            }
        }
    }
}

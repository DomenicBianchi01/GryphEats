//
//  OrderTrackingViewModel.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-11-05.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Foundation

// MARK: - OrderTrackingViewModel

class OrderTrackingViewModel {
    
    // MARK: OrderTrackingError
    
    enum OrderTrackingError: Error, LocalizedError {
        case cancelError
        case reorderError
        
        // MARK: Internal
        
        var recoverySuggestion: String? {
            switch self {
            case .cancelError:
                return "This order could not be cancelled. It may because this order is already in progress."
            case .reorderError:
                return "This order could not be placed at this time. Please try again later."
            }
        }
        
        var errorDescription: String? {
            "Error"
        }
    }
    
    // MARK: Lifecycle
    
    init(order: Order) {
        self.order = order
    }
    
    // MARK: Internal
    
    func cancelOrder(completion: @escaping (Bool) -> Void) {
        GraphClient.shared.perform(
            mutation: UpdateOrderMutation(
                orderID: order.id,
                status: .cancelled,
                restaurantID: order.restaurantID))
        { result in
            switch result {
            case .success(let data):
                completion(data.updateOrder?.success ?? false)
            case .failure:
                completion(false)
            }
        }
    }
    
    let order: Order
    
}

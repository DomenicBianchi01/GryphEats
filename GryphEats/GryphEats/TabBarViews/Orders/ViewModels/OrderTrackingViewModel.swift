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
        
        // MARK: Internal
        
        var recoverySuggestion: String? {
            "This order could not be cancelled. It may because this order is already in progress."
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
        GraphClient.shared.perform(mutation: UpdateOrderMutation(orderID: order.id, status: 4)) { result in
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

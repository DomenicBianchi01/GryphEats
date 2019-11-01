//
//  Order.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-02.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - Order

class Order: Items, ObservableObject, Identifiable {
    
    // MARK: Lifecycle
        
    init(id: Int, customer: Customer, status: Status = .new, timePlaced: String, items: [RestaurantFoodItem] = []) {
        self.id = id
        self.customer = customer
        self.status = status
        self.timePlaced = timePlaced
        
        super.init(items: items)
    }
    
    // MARK: Status
    
    enum Status: Int, CaseIterable, Identifiable {
        case new
        case inProgress
        case readyForPickup
        case pickedUp
        
        // MARK: Internal
        
        var asString: String {
            switch self {
            case .new:
                return "Order Placed"
            case .inProgress:
                return "In Progress"
            case .readyForPickup:
                return "Ready For Pickup"
            case .pickedUp:
                return "Picked Up"
            }
        }
        
        var id: Status { self }
    }
    
    // MARK: Internal
    
    @Published var status: Status
    
    let id: Int
    let customer: Customer
    let timePlaced: String //TODO: Date object instead
    
}

//
//  Order.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-02.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - Order

class Order: ObservableObject, Identifiable {
        
    init(id: Int, customer: Customer, status: Status = .new, time: String, foodItems: [FoodItem] = []) {
        self.id = id
        self.customer = customer
        self.status = status
        self.time = time
        self.foodItems = foodItems
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
    
    var id: Int = 0
    var customer: Customer = Customer(name: "")
    @Published var status: Status = .new
    var time: String = "" //TODO: Date object instead
    var foodItems: [FoodItem]
    
}

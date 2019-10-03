//
//  Order.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-02.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

// MARK: - Order

struct Order {
    
    // MARK: Status
    
    enum Status {
        case new
        case inProgress
        case readyForPickup
        case pickedUp
    }
    
    // MARK: Internal
    
    var customer: Customer
    var status: Status
    var time: String //TODO: Date object instead
    
}

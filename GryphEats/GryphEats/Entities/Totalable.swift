//
//  Totalable.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-31.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import Foundation
import SwiftUI

// MARK: - Items

// NOTE: I wanted this class to really be a protocol instead. However, having a property within the protocol that needs
// to be "published" wasn't working out as I hoped (the app was crashing for some reason...never gave me a proper error
// message)

/// Contains functions that can calculate the subtotal, tax, and total given an array of items
class Items {
    
    // MARK: PriceType

    enum PriceType {
        case onCampus
        case offCampus
        case regular
    }
    
    // MARK: Lifecycle
    
    init(items: [RestaurantFoodItem]) {
        self.items = items
    }
    
    // MARK: Internal
    
    @Published var items: [RestaurantFoodItem]
    
    func subtotal(for type: PriceType = .regular) -> Double {
        let subtotal = items.reduce(0) { $0 + ($1.foodItem.price) }
        
        switch type {
        case .onCampus:
            return subtotal * 0.7
        case .offCampus:
            return subtotal * 0.9
        case .regular:
            return subtotal
        }
    }
    
    func tax(for type: PriceType = .regular) -> Double {
        let subtotalAmount = subtotal(for: type)
        
        switch type {
        case .onCampus:
            return 0
        case .offCampus:
            return subtotalAmount * 0.08
        case .regular:
            return subtotalAmount * 0.13
        }
    }
    
    func total(for type: PriceType = .regular) -> Double {
        subtotal(for: type) + tax(for: type)
    }
}

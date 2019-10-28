//
//  Cart.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-09.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - Cart

class Cart: ObservableObject {
    
    // MARK: PriceType
    
    enum PriceType {
        case onCampus
        case offCampus
        case regular
    }
    
    // MARK: Lifecycle
    
    init(items: [GraphFoodItem] = []) {
        self.items = items
    }
    
    // MARK: Internal
    
    @Published var items: [GraphFoodItem]
    
    func subtotal(for type: PriceType = .regular) -> Double {
        let subtotal = items.reduce(0) { $0 + ($1.price ?? 0) }
        
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
    
    func delete(item: GraphFoodItem) {
        guard let index = items.firstIndex(where: { $0 == item }) else {
            return
        }
        
        items.remove(at: index)
    }
    
    func clear() {
        items.removeAll()
    }
}

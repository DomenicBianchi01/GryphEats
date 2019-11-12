//
//  Cart.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-09.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - Cart

class Cart: Items, ObservableObject {
    
    // MARK: Lifecycle
    
    override init(items: [RestaurantFoodItem] = []) {
        super.init(items: items)
    }
    
    // MARK: Internal
    
    @Published var specialInstructions: String? = nil
    
    func delete(item: RestaurantFoodItem) {
        guard let index = items.firstIndex(where: { $0.foodItem == item.foodItem }) else {
            return
        }
        
        items.remove(at: index)
    }
    
    func clear() {
        items.removeAll()
        specialInstructions = nil
    }
}

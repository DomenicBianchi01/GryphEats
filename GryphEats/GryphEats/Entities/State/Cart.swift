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
    
    // MARK: Lifecycle

    init(items: [FoodItem] = []) {
        self.items = items
    }
    
    // MARK: Internal

    @Published var items: [FoodItem]

}

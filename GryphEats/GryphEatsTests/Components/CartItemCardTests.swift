//
//  CartItemCardTests.swift
//  GryphEatsTests
//
//  Created by Domenic Bianchi on 2019-10-15.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import GryphEats

class CartItemCardTests: XCTestCase {
    
    let record = false

    func testCartItemCard() {
        let card = CartItemCard(
            item: RestaurantFoodItem(
                foodItem: GraphFoodItem(id: "0", name: "Hamburger", price: 9.99),
                restaurantId: "1",
                restaurantName: "Mom's Kitchen"),
            deleteAction: {})
        
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
}

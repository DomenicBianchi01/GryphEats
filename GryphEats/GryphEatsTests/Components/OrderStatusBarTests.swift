//
//  OrderStatusBarTests.swift
//  GryphEatsTests
//
//  Created by Domenic Bianchi on 2019-10-31.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import GryphEats

class OrderStatusBarTests: XCTestCase {
    
    let record = false
    
    func testOrderStatusBar_orderPlaced() {
        assertSnapshot(
            matching: UIHostingController(rootView: OrderStatusBar(status: .new).environmentObject(cart)),
            as: .image,
            record: record)
    }
    
    func testOrderStatusBar_inProgress() {
        assertSnapshot(
            matching: UIHostingController(rootView: OrderStatusBar(status: .inProgress).environmentObject(cart)),
            as: .image,
            record: record)
    }
    
    func testOrderStatusBar_readyForPickup() {
        assertSnapshot(
            matching: UIHostingController(rootView: OrderStatusBar(status: .readyForPickup).environmentObject(cart)),
            as: .image,
            record: record)
    }
    
    func testOrderStatusBar_pickedUp() {
        assertSnapshot(
            matching: UIHostingController(rootView: OrderStatusBar(status: .pickedUp).environmentObject(cart)),
            as: .image,
            record: record)
    }
    
    private let cart = Cart(
        items: [RestaurantFoodItem(
            foodItem: GraphFoodItem(id: "0", displayName: "Hamburger 1", price: 9.99),
            restaurantId: "1",
            restaurantName: "100 Mile Grill")])
}

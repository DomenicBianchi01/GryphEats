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
            matching: UIHostingController(
                rootView: OrderStatusBar(
                    status: .new,
                    cancelAction: {},
                    reorderAction: {}).environmentObject(cart)),
            as: .image,
            record: record)
    }
    
    func testOrderStatusBar_inProgress() {
        assertSnapshot(
            matching: UIHostingController(
                rootView: OrderStatusBar(
                    status: .inProgress,
                    cancelAction: {},
                    reorderAction: {}).environmentObject(cart)),
            as: .image,
            record: record)
    }
    
    func testOrderStatusBar_readyForPickup() {
        assertSnapshot(
            matching: UIHostingController(
                rootView: OrderStatusBar(
                    status: .readyForPickup,
                    cancelAction: {},
                    reorderAction: {}).environmentObject(cart)),
            as: .image,
            record: record)
    }
    
    func testOrderStatusBar_pickedUp() {
        assertSnapshot(
            matching: UIHostingController(
                rootView: OrderStatusBar(
                    status: .pickedUp,
                    cancelAction: {},
                    reorderAction: {}).environmentObject(cart)),
            as: .image,
            record: record)
    }
    
    func testOrderStatusBar_cancelled() {
        assertSnapshot(
            matching: UIHostingController(
                rootView: OrderStatusBar(
                    status: .cancelled,
                    cancelAction: {},
                    reorderAction: {}).environmentObject(cart)),
            as: .image,
            record: record)
    }
    
    func testOrderStatusBar_dark_orderPlaced() {
        assertSnapshot(
            matching: UIHostingController(
                rootView: OrderStatusBar(
                    status: .new,
                    cancelAction: {},
                    reorderAction: {})
                    .background(Color.lightGray(for: .dark))
                    .environmentObject(cart)
                    .environment(\.colorScheme, .dark)),
            as: .image,
            record: record)
    }
    
    func testOrderStatusBar_dark_inProgress() {
        assertSnapshot(
            matching: UIHostingController(
                rootView: OrderStatusBar(
                    status: .inProgress,
                    cancelAction: {},
                    reorderAction: {})
                    .background(Color.lightGray(for: .dark))
                    .environmentObject(cart)
                    .environment(\.colorScheme, .dark)),
            as: .image,
            record: record)
    }
    
    func testOrderStatusBar_dark_readyForPickup() {
        assertSnapshot(
            matching: UIHostingController(
                rootView: OrderStatusBar(
                    status: .readyForPickup,
                    cancelAction: {},
                    reorderAction: {})
                    .background(Color.lightGray(for: .dark))
                    .environmentObject(cart)
                    .environment(\.colorScheme, .dark)),
            as: .image,
            record: record)
    }
    
    func testOrderStatusBar_dark_pickedUp() {
        assertSnapshot(
            matching: UIHostingController(
                rootView: OrderStatusBar(
                    status: .pickedUp,
                    cancelAction: {},
                    reorderAction: {})
                    .background(Color.lightGray(for: .dark))
                    .environmentObject(cart)
                    .environment(\.colorScheme, .dark)),
            as: .image,
            record: record)
    }
    
    func testOrderStatusBar_dark_cancelled() {
        assertSnapshot(
            matching: UIHostingController(
                rootView: OrderStatusBar(
                    status: .cancelled,
                    cancelAction: {},
                    reorderAction: {})
                    .background(Color.lightGray(for: .dark))
                    .environmentObject(cart)
                    .environment(\.colorScheme, .dark)),
            as: .image,
            record: record)
    }
    
    private let cart = Cart(
        items: [RestaurantFoodItem(
            foodItem: GraphFoodItem(id: "0", name: "Hamburger 1", price: 9.99),
            restaurantId: "1",
            restaurantName: "100 Mile Grill")])
}

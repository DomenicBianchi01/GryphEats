//
//  OrderHistoryCard.swift
//  GryphEatsTests
//
//  Created by Domenic Bianchi on 2019-10-24.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import GryphEats

class OrderHistoryCardTests: XCTestCase {
    
    var record = false
    
    func testOrderHistoryCard_New() {
        let card = OrderHistoryCard(order: order(status: .new))
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    func testOrderHistoryCard_InProgress() {
        let card = OrderHistoryCard(order: order(status: .inProgress))
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    func testOrderHistoryCard_ReadyForPickup() {
        let card = OrderHistoryCard(order: order(status: .readyForPickup))
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    func testOrderHistoryCard_PickedUp() {
        let card = OrderHistoryCard(order: order(status: .pickedUp))
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    private func order(status: Order.Status) -> Order {
        Order(
            id: 0,
            customer: Customer(name: "Billy Bob"),
            status: status,
            timePlaced: "12:00pm",
            items: [
                RestaurantFoodItem(
                    foodItem: GraphFoodItem(id: "1", displayName: "Hamburger", price: 9.99),
                    restaurantId: "1",
                    restaurantName: "Mom's Kitchen")])
    }
}

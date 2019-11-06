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
        let card = OrderHistoryCard(order: order(status: .neworder))
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    func testOrderHistoryCard_InProgress() {
        let card = OrderHistoryCard(order: order(status: .inprogress))
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    func testOrderHistoryCard_ReadyForPickup() {
        let card = OrderHistoryCard(order: order(status: .ready))
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    func testOrderHistoryCard_PickedUp() {
        let card = OrderHistoryCard(order: order(status: .pickedup))
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    func testOrderHistoryCard_Cancelled() {
        let card = OrderHistoryCard(order: order(status: .cancelled))
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    private func order(status: OrderStatus) -> Order {
        Order(
            id: "0",
            restaurantID: "1",
            customer: Customer(name: "Billy Bob"),
            status: status,
            timePlaced: "2019-11-05T11:03:09.000Z",
            items: [
                RestaurantFoodItem(
                    foodItem: GraphFoodItem(id: "1", name: "Hamburger", price: 9.99),
                    restaurantId: "1",
                    restaurantName: "Mom's Kitchen")])
    }
}

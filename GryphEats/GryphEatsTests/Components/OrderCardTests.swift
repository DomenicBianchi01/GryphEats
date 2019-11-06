//
//  OrderCardTests.swift
//  GryphEatsTests
//
//  Created by Domenic Bianchi on 2019-10-03.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import GryphEats

class OrderCardTests: XCTestCase {
    
    var record = false

    func testOrderCard_New() {
        let card = OrderCard(order: Order(id: "0", restaurantID: "1", customer: customer, status: .neworder, timePlaced: time))
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    func testOrderCard_InProgress() {
        let card = OrderCard(order: Order(id: "0", restaurantID: "1", customer: customer, status: .inprogress, timePlaced: time))
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    func testOrderCard_ReadyForPickup() {
        let card = OrderCard(order: Order(id: "0", restaurantID: "1", customer: customer, status: .ready, timePlaced: time))
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    func testOrderCard_PickedUp() {
        let card = OrderCard(order: Order(id: "0", restaurantID: "1", customer: customer, status: .pickedup, timePlaced: time))
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    private let customer = Customer(name: "Billy Bob")
    private let time = "2019-11-05T11:03:09.000Z"

}

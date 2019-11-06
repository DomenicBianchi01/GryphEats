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
        let card = OrderCard(order: Order(id: "0", customer: customer, status: .new, timePlaced: time))
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    func testOrderCard_InProgress() {
        let card = OrderCard(order: Order(id: "0", customer: customer, status: .inProgress, timePlaced: time))
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    func testOrderCard_ReadyForPickup() {
        let card = OrderCard(order: Order(id: "0", customer: customer, status: .readyForPickup, timePlaced: time))
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    func testOrderCard_PickedUp() {
        let card = OrderCard(order: Order(id: "0", customer: customer, status: .pickedUp, timePlaced: time))
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    private let customer = Customer(name: "Billy Bob")
    private let time = "2019-11-05T11:03:09.000Z"

}

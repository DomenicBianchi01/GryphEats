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
        let card = OrderHistoryCard(order: Order(id: 0, customer: customer, status: .new, time: "12:00pm"))
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    func testOrderHistoryCard_InProgress() {
        let card = OrderHistoryCard(order: Order(id: 0, customer: customer, status: .inProgress, time: "12:00pm"))
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    func testOrderHistoryCard_ReadyForPickup() {
        let card = OrderHistoryCard(order: Order(id: 0, customer: customer, status: .readyForPickup, time: "12:00pm"))
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    func testOrderHistoryCard_PickedUp() {
        let card = OrderHistoryCard(order: Order(id: 0, customer: customer, status: .pickedUp, time: "12:00pm"))
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    private let customer = Customer(name: "Billy Bob")

}

//
//  PriceSummaryCardTests.swift
//  GryphEatsTests
//
//  Created by Domenic Bianchi on 2019-10-15.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import GryphEats

class PriceSummaryCardTests: XCTestCase {
    
    let record = false
    
    func testPriceSummaryCard_Full() {
        let card = PriceSummaryCard(action: { _ in }).environmentObject(Cart(
            items: [
                GraphFoodItem(id: "0", restaurantId: "1", displayName: "Hamburger", price: 9.99)
            ]
        ))
        
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    func testPriceSummaryCard_OnCampus() {
        let card = PriceSummaryCard(displayMode: .onCampusMealPlan, action: { _ in }).environmentObject(Cart(
            items: [
                GraphFoodItem(id: "0", restaurantId: "1", displayName: "Hamburger", price: 9.99)
            ]
        ))
        
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    func testPriceSummaryCard_Ultra() {
        let card = PriceSummaryCard(displayMode: .ultraMealPlan, action: { _ in }).environmentObject(Cart(
            items: [
                GraphFoodItem(id: "0", restaurantId: "1", displayName: "Hamburger", price: 9.99)
            ]
        ))
        
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
}

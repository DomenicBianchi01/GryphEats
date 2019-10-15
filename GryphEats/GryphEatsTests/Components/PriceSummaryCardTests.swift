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
    
    func testPriceSummaryCard() {
        let card = PriceSummaryCard().environmentObject(Cart(
            items: [
                FoodItem(id: 0, name: "Hamburger", imageName: "")
            ]
        ))
        
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
}

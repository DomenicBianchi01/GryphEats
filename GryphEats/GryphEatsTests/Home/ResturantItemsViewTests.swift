//
//  ResturantItemsViewTests.swift
//  GryphEatsTests
//
//  Created by Domenic Bianchi on 2019-10-08.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import GryphEats

class ResturantItemsViewTests: XCTestCase {
    
    let record = false
    
    func testResturantItemsView() {
        let view = ResturantItemsView(
            resturant: Resturant(
                id: 0,
                name: "100 Mile Grill",
                foodItems: [
                    FoodItem(id: 0, name: "Hamburger 1", image: "hamburger"),
                    FoodItem(id: 1, name: "Hamburger 2", image: "hamburger"),
                    FoodItem(id: 2, name: "Hamburger 3", image: "hamburger"),
                    FoodItem(id: 3, name: "Hamburger 4", image: "hamburger"),
                    FoodItem(id: 4, name: "Hamburger 5", image: "hamburger")
            ]))
        
        assertSnapshot(matching: UIHostingController(rootView: view), as: .image, record: record)
    }
}

//
//  RestaurantItemsViewTests.swift
//  GryphEatsTests
//
//  Created by Domenic Bianchi on 2019-10-08.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import GryphEats

class RestaurantItemsViewTests: XCTestCase {
    
    let record = false
    
    func testRestaurantItemsView() {
        let view = RestaurantItemsView(
            restaurant: Restaurant(
                id: "0",
                name: "100 Mile Grill",
                foodItems: [
                    FoodItem(id: 0, name: "Hamburger 1", imageName: "hamburger"),
                    FoodItem(id: 1, name: "Hamburger 2", imageName: "hamburger"),
                    FoodItem(id: 2, name: "Hamburger 3", imageName: "hamburger"),
                    FoodItem(id: 3, name: "Hamburger 4", imageName: "hamburger"),
                    FoodItem(id: 4, name: "Hamburger 5", imageName: "hamburger")
            ])) { _ in }
        
        assertSnapshot(matching: UIHostingController(rootView: view), as: .image, record: record)
    }
}

//
//  SliderViewTests.swift
//  GryphEatsTests
//
//  Created by Domenic Bianchi on 2019-10-08.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import GryphEats

class SliderViewTests: XCTestCase {
    
    let record = false
    
    func testFoodItemsSliderView() {
        let view = SliderView(type: .foodItems([
            RestaurantFoodItem(
                foodItem: GraphFoodItem(id: "0", name: "Hamburger 1", price: 2.00),
                restaurantId: "1",
                restaurantName: "Mom's Kitchen"),
            RestaurantFoodItem(
                foodItem: GraphFoodItem(id: "1", name: "Hamburger 2", price: 2.00),
                restaurantId: "1",
                restaurantName: "Mom's Kitchen"),
            RestaurantFoodItem(
                foodItem: GraphFoodItem(id: "2", name: "Hamburger 3", price: 2.00),
                restaurantId: "1",
                restaurantName: "Mom's Kitchen"),
            RestaurantFoodItem(
                foodItem: GraphFoodItem(id: "3", name: "Hamburger 4", price: 2.00),
                restaurantId: "1",
                restaurantName: "Mom's Kitchen"),
            RestaurantFoodItem(
                foodItem: GraphFoodItem(id: "4", name: "Hamburger 5", price: 2.00),
                restaurantId: "1",
                restaurantName: "Mom's Kitchen")
        ])) { _ in }
        
        assertSnapshot(matching: UIHostingController(rootView: view), as: .image, record: record)
    }
}

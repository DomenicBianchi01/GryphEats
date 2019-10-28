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
    
    func testCategorySliderView() {
        let view = SliderView(type: .categories([
            Category(id: 0, name: "Fish"),
            Category(id: 1, name: "Pasta"),
            Category(id: 2, name: "Pizza"),
            Category(id: 3, name: "Meat"),
            Category(id: 4, name: "Dessert")
        ])) { _ in }

        assertSnapshot(matching: UIHostingController(rootView: view), as: .image, record: record)
    }
    
    func testFoodItemsSliderView() {
        let view = SliderView(type: .foodItems([
            GraphFoodItem(id: "0", restaurantId: "1", displayName: "Hamburger 1", price: 2.00),
            GraphFoodItem(id: "1", restaurantId: "1", displayName: "Hamburger 2", price: 2.00),
            GraphFoodItem(id: "2", restaurantId: "1", displayName: "Hamburger 3", price: 2.00),
            GraphFoodItem(id: "3", restaurantId: "1", displayName: "Hamburger 4", price: 2.00),
            GraphFoodItem(id: "4", restaurantId: "1", displayName: "Hamburger 5", price: 2.00)
        ])) { _ in }

        assertSnapshot(matching: UIHostingController(rootView: view), as: .image, record: record)
    }
    
    func testIngredientsSliderView() {
        let view = SliderView(type: .ingredients([
            Ingredient(id: 0, name: "Tomato", imageName: "tomato"),
            Ingredient(id: 1, name: "Lettuce", imageName: "tomato"),
            Ingredient(id: 2, name: "Onion", imageName: "tomato"),
            Ingredient(id: 3, name: "Pepper", imageName: "tomato"),
            Ingredient(id: 4, name: "Black Olives", imageName: "tomato"),
        ])) { _ in }

        assertSnapshot(matching: UIHostingController(rootView: view), as: .image, record: record)
    }
}

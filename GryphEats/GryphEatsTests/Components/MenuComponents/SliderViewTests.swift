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
    
    func x_testFoodItemsSliderView() {
        let view = SliderView(type: .foodItems([
            RestaurantFoodItem(
                foodItem: FoodItemDetails(id: "0", name: "Hamburger 1", price: 2.00, inStock: true),
                restaurantId: "1",
                restaurantName: "Mom's Kitchen"),
            RestaurantFoodItem(
                foodItem: FoodItemDetails(id: "1", name: "Hamburger 2", price: 2.00, inStock: true),
                restaurantId: "1",
                restaurantName: "Mom's Kitchen"),
            RestaurantFoodItem(
                foodItem: FoodItemDetails(id: "2", name: "Hamburger 3", price: 2.00, inStock: true),
                restaurantId: "1",
                restaurantName: "Mom's Kitchen"),
            RestaurantFoodItem(
                foodItem: FoodItemDetails(id: "3", name: "Hamburger 4", price: 2.00, inStock: true),
                restaurantId: "1",
                restaurantName: "Mom's Kitchen"),
            RestaurantFoodItem(
                foodItem: FoodItemDetails(id: "4", name: "Hamburger 5", price: 2.00, inStock: true),
                restaurantId: "1",
                restaurantName: "Mom's Kitchen")
        ])) { _ in }
        
        assertSnapshot(matching: UIHostingController(rootView: view), as: .image, record: record)
    }
}

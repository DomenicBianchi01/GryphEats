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
            restaurant: GraphRestaurant(
                id: "0",
                name: "100 Mile Grill",
                menu: [
                    Menu(isActive: true, menuItems: [
                        Menu.MenuItem(item:
                            GraphFoodItem(id: "0", displayName: "Hamburger 1", price: 9.99)),
                        Menu.MenuItem(item:
                            GraphFoodItem(id: "1", displayName: "Hamburger 2", price: 9.99)),
                        Menu.MenuItem(item:
                            GraphFoodItem(id: "2", displayName: "Hamburger 3", price: 9.99)),
                        Menu.MenuItem(item:
                            GraphFoodItem(id: "3", displayName: "Hamburger 4", price: 9.99)),
                        Menu.MenuItem(item:
                            GraphFoodItem(id: "4", displayName: "Hamburger 5", price: 9.99))
                    ])
            ])) { _ in }
        
        assertSnapshot(matching: UIHostingController(rootView: view), as: .image, record: record)
    }
}

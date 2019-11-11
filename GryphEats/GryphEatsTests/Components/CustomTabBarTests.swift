//
//  CustomTabBarTests.swift
//  GryphEatsTests
//
//  Created by Domenic Bianchi on 2019-10-23.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import GryphEats

class CustomTabBarTests: XCTestCase {
    
    let record = false

    func testCustomTabBar() {
        let tabBar = CustomTabBar(selectedIndex: .constant(1), items: [
            CustomTabBarItem(icon: .system(name: "person"), title: "Option 1"),
            CustomTabBarItem(icon: .system(name: "person"), title: "Option 2"),
            CustomTabBarItem(icon: .system(name: "person"), title: "Option 3")
        ])
        
        assertSnapshot(matching: UIHostingController(rootView: tabBar), as: .image, record: record)
    }
    
    func testCustomTabBar_dark() {
        let tabBar = CustomTabBar(selectedIndex: .constant(1), items: [
            CustomTabBarItem(icon: .system(name: "person"), title: "Option 1"),
            CustomTabBarItem(icon: .system(name: "person"), title: "Option 2"),
            CustomTabBarItem(icon: .system(name: "person"), title: "Option 3")
        ]).environment(\.colorScheme, .dark)
        
        assertSnapshot(matching: UIHostingController(rootView: tabBar), as: .image, record: record)
    }
}

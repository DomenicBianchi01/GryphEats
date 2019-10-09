//
//  NavigationHeaderViewTests.swift
//  GryphEatsTests
//
//  Created by Domenic Bianchi on 2019-10-08.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import GryphEats

class NavigationHeaderViewTests: XCTestCase {
    
    let record = false
    
    func testNavigationHeaderView() {
        let view = NavigationHeaderView(
            title: "A Title",
            navigationColor: .blue,
            contentBackgroundColor: .green)
        {
            Text("Some text")
        }

        assertSnapshot(matching: UIHostingController(rootView: view), as: .image, record: record)
    }
}

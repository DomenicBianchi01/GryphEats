//
//  CategoryCardTests.swift
//  GryphEatsTests
//
//  Created by Domenic Bianchi on 2019-10-08.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import GryphEats

class CategoryCardTests: XCTestCase {
    
    let record = false
    
    func testCategoryCard() {
        assertSnapshot(
            matching: UIHostingController(rootView: CategoryCard(name: "A Category", onTap: {})),
            as: .image,
            record: record)
    }
}

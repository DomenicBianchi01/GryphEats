//
//  HeaderViewTests.swift
//  GryphEatsTests
//
//  Created by Domenic Bianchi on 2019-10-05.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import GryphEats

class HeaderViewTestsTests: XCTestCase {
    
    let record = false

    func testHeaderView() {
        assertSnapshot(
            matching: UIHostingController(
                rootView: HeaderView(
                    title: "A Header",
                    subtitle: "A subtitle")),
            as: .image,
            record: record)
    }
}

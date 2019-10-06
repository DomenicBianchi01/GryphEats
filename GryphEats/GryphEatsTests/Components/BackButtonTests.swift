//
//  BackButtonTests.swift
//  GryphEatsTests
//
//  Created by Domenic Bianchi on 2019-10-05.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import GryphEats

class BackButtonTests: XCTestCase {
    
    let record = false

    func testBackButton() {
        assertSnapshot(matching: CustomUIHostingController(rootView: BackButton {}), as: .image, record: record)
    }
}

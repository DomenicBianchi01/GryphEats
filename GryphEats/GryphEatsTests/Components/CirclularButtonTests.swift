//
//  CirclularButtonTests.swift
//  GryphEatsTests
//
//  Created by Domenic Bianchi on 2019-10-05.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import GryphEats

class CirclularButtonTests: XCTestCase {
    
    let record = false

    func testCirclularButton() {
        let button = CircularButton(
            text: Text("A button"),
            backgroundColor: .green,
            foregroundColor: .yellow,
            borderColor: .blue)
        
        assertSnapshot(matching: UIHostingController(rootView: button), as: .image, record: record)
    }
}

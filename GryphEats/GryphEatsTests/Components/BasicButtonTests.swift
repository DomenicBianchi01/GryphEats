//
//  BasicButtonTests.swift
//  GryphEatsTests
//
//  Created by Domenic Bianchi on 2019-10-05.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import GryphEats

class BasicButtonTests: XCTestCase {
    
    let record = false

    func testBasicButton() {
        let button = BasicButton(
            text: Text("A button"),
            backgroundColor: .green,
            foregroundColor: .yellow,
            minimumWidth: 100)
        
        assertSnapshot(matching: UIHostingController(rootView: button), as: .image, record: record)
    }
    
    func testBasicButton_dark() {
        let button = BasicButton(
            text: Text("A button"),
            backgroundColor: .green,
            foregroundColor: .yellow,
            minimumWidth: 100).background(Color.black).environment(\.colorScheme, .dark)
        
        assertSnapshot(matching: UIHostingController(rootView: button), as: .image, record: record)
    }
}

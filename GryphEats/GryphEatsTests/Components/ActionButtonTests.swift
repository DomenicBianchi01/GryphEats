//
//  ActionButtonTests.swift
//  GryphEatsTests
//
//  Created by Domenic Bianchi on 2019-10-15.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import GryphEats

class ActionButtonTests: XCTestCase {
    
    let record = false

    func testActionButton() {
        let button = ActionButton(text: "Do an action!", action: {})
        
        assertSnapshot(matching: UIHostingController(rootView: button), as: .image, record: record)
    }
    
    func testActionButton_dark() {
        let button = ActionButton(text: "Do an action!", action: {}).colorScheme(.dark)
        
        assertSnapshot(matching: UIHostingController(rootView: button), as: .image, record: record)
    }
}

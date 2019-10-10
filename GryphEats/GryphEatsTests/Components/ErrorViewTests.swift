//
//  ErrorViewTests.swift
//  GryphEatsTests
//
//  Created by Domenic Bianchi on 2019-10-10.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import GryphEats

class ErrorViewTests: XCTestCase {
    
    let record = false

    func testErrorView() {
        let view = ErrorView(infoText: "Whoops!", buttonText: "Try Again") {}
        
        assertSnapshot(matching: UIHostingController(rootView: view), as: .image, record: record)
    }
}

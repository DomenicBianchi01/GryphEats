//
//  BageButtonTests.swift
//  GryphEatsTests
//
//  Created by Domenic Bianchi on 2019-10-14.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import GryphEats

class BageButtonTests: XCTestCase {
    
    let record = false

    func testNoBadge() {
        let button = BadgeButton(action: {}) {
            Image(systemName: "cart")
                .padding(.all, 10)
                .foregroundColor(.black)
        }
        
        assertSnapshot(matching: UIHostingController(rootView: button), as: .image, record: record)
    }
    
    func testWithBadge() {
        let button = BadgeButton(badgeNumber: 1, action: {}) {
            Image(systemName: "cart")
                .padding(.all, 10)
                .foregroundColor(.black)
        }
        
        assertSnapshot(matching: UIHostingController(rootView: button), as: .image, record: record)
    }
    
    func testNoBadge_dark() {
        let button = BadgeButton(action: {}) {
            Image(systemName: "cart")
                .padding(.all, 10)
        }.background(Color.black).environment(\.colorScheme, .dark)
        
        assertSnapshot(matching: UIHostingController(rootView: button), as: .image, record: record)
    }
    
    func testWithBadge_dark() {
        let button = BadgeButton(badgeNumber: 1, action: {}) {
            Image(systemName: "cart")
                .padding(.all, 10)
        }.background(Color.black).environment(\.colorScheme, .dark)
        
        assertSnapshot(matching: UIHostingController(rootView: button), as: .image, record: record)
    }
}

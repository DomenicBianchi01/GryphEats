//
//  CreditCardTests.swift
//  GryphEatsTests
//
//  Created by Domenic Bianchi on 2019-10-19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import GryphEats

class CreditCardTests: XCTestCase {
    
    let record = false

    func testCreditCard_visa() {
        let card = CreditCard(brand: .visa, lastFourDigits: "1234")
    
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    func testCreditCard_mastercard() {
        let card = CreditCard(brand: .mastercard, lastFourDigits: "1234")
    
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
}

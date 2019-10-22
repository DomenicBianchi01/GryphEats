//
//  PaymentInfoTextFieldTests.swift
//  GryphEatsTests
//
//  Created by Domenic Bianchi on 2019-10-19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import GryphEats

class PaymentInfoTextFieldTests: XCTestCase {
    
    let record = false

    func testCreditCardTextField_basic() {
        let textField = PaymentInfoTextField(
            displayMode: .basic,
            header: "A header",
            placeholder: "Placeholder",
            text: .constant(""))
    
        assertSnapshot(matching: UIHostingController(rootView: textField), as: .image, record: record)
    }
    
    func testCreditCardTextField_creditCardNumber() {
        let textField = PaymentInfoTextField(
            displayMode: .creditCardNumber,
            header: "A header",
            placeholder: "Placeholder",
            text: .constant(""))
    
        assertSnapshot(matching: UIHostingController(rootView: textField), as: .image, record: record)
    }
    
    func testCreditCardTextField_question() {
        let textField = PaymentInfoTextField(
            displayMode: .question(info: "A question"),
            header: "A header",
            placeholder: "Placeholder",
            text: .constant(""))
    
        assertSnapshot(matching: UIHostingController(rootView: textField), as: .image, record: record)
    }
    
    func testCreditCardTextField_withoutSubtitle() {
        let textField = PaymentInfoTextField(
            displayMode: .basic,
            subtitleDisplayMode: .hidden,
            header: "A header",
            placeholder: "Placeholder",
            text: .constant("Some text"))
    
        assertSnapshot(matching: UIHostingController(rootView: textField), as: .image, record: record)
    }
    
    func testCreditCardTextField_withSubtitle() {
        let textField = PaymentInfoTextField(
            displayMode: .basic,
            subtitleDisplayMode: .visible(text: "A subtitle"),
            header: "A header",
            placeholder: "Placeholder",
            text: .constant("Some text"))
    
        assertSnapshot(matching: UIHostingController(rootView: textField), as: .image, record: record)
    }
}

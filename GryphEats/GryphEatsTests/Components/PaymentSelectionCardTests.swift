//
//  PaymentSelectionCardTests.swift
//  GryphEatsTests
//
//  Created by Domenic Bianchi on 2019-10-19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import GryphEats

class PaymentSelectionCardTests: XCTestCase {
    
    let record = false

    func testPaymentSelectionCard_visa() {
        let card = PaymentSelectionCard(
        paymentMethod: PaymentMethod(cardType: .visa, accountName: "Billy Bob", accountNumber: 1234)) {}
    
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    func testPaymentSelectionCard_mastercard() {
        let card = PaymentSelectionCard(
        paymentMethod: PaymentMethod(cardType: .mastercard, accountName: "Billy Bob", accountNumber: 1234)) {}
    
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    func testPaymentSelectionCard_studentCardOnCampus() {
        let card = PaymentSelectionCard(
        paymentMethod: PaymentMethod(
            cardType: .student(mealPlanType: .onCampus),
            accountName: "Billy Bob",
            accountNumber: 1234)) {}
    
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    func testPaymentSelectionCard_studentCardUltra() {
        let card = PaymentSelectionCard(
        paymentMethod: PaymentMethod(
            cardType: .student(mealPlanType: .ultra),
            accountName: "Billy Bob",
            accountNumber: 1234)) {}
    
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
    
    func testPaymentSelectionCard_selected() {
        let card = PaymentSelectionCard(
        paymentMethod: PaymentMethod(cardType: .visa, accountName: "Billy Bob", accountNumber: 1234),
        isSelected: true) {}
    
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
}

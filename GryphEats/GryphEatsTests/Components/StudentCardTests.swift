//
//  StudentCardTests.swift
//  GryphEatsTests
//
//  Created by Domenic Bianchi on 2019-10-03.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import GryphEats

class StudentCardTests: XCTestCase {
    
    let record = false

    func testStudentCard() {
        let card = StudentCard(customer: Customer(name: "Billy Bob", mealPlan: MealPlan(currentBalance: 5000, accountNumber: "1234")))
        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
    }
}

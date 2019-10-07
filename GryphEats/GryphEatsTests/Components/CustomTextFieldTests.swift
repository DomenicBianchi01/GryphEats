//
//  CustomTextFieldTests.swift
//  GryphEatsTests
//
//  Created by Domenic Bianchi on 2019-10-05.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import GryphEats

class CustomTextFieldTests: XCTestCase {
    
    let record = false

    func testTextFieldText() {
        let textField = CustomTextField(
            header: "A header",
            placeholder: "A placeholder",
            text: .constant("Some text"))
        
        assertSnapshot(matching: CustomUIHostingController(rootView: textField), as: .image, record: record)
    }
    
    func testTextFieldPlaceholder() {
        let textField = CustomTextField(
            header: "A header",
            placeholder: "A placeholder",
            text: .constant(""))
        
        assertSnapshot(matching: CustomUIHostingController(rootView: textField), as: .image, record: record)
    }
    
    func testTextFieldWithSubtitle() {
        let textField = CustomTextField(
            header: "A header",
            subtitle: "A subtitle",
            placeholder: "A placeholder",
            text: .constant(""))
        
        assertSnapshot(matching: CustomUIHostingController(rootView: textField), as: .image, record: record)
    }
    
    func testSecureTextFieldText() {
        let textField = CustomTextField(
            header: "A header",
            placeholder: "A placeholder",
            text: .constant("apassword"),
            isSecure: true)
        
        assertSnapshot(matching: CustomUIHostingController(rootView: textField), as: .image, record: record)
    }
}

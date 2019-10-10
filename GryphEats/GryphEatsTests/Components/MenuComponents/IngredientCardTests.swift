//
//  IngredientCardTests.swift
//  GryphEatsTests
//
//  Created by Domenic Bianchi on 2019-10-10.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SnapshotTesting
import SwiftUI
import XCTest

@testable import GryphEats

class IngredientCardTests: XCTestCase {
    
    let record = false
    
    func testIngredientCard_NotSelected() {
        assertSnapshot(
            matching: UIHostingController(
                rootView: IngredientCard(
                    ingredient: Ingredient(id: 0, name: "Tomato", imageName: "tomato"),
                    selectionUpdated: { _ in })),
            as: .image,
            record: record)
    }
    
    // TODO: Not sure how to test the selected state. Doesn't seem like editing the @State property actually triggers
    // the view to refresh
    
//    func testIngredientCard_Selected() {
//        let card = IngredientCard(
//            ingredient: Ingredient(id: 0, name: "Tomato", imageName: "tomato"),
//            selectionUpdated: { _ in })
//
//        card.isSelected = true
//
//        assertSnapshot(matching: UIHostingController(rootView: card), as: .image, record: record)
//    }
}

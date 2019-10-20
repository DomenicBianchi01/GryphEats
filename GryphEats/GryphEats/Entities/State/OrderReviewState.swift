//
//  OrderReviewState.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-15.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - OrderReviewState

class OrderReviewState: ObservableObject {

    // MARK: State

    enum State: Equatable {
        case summary
        case checkout
        case confirmed
    }

    // MARK: Internal

    @Published var state: State = .summary

}

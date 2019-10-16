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
        case checkout(paymentOption: PaymentOption)
        case confirmed
        
        /// DO NOT USE THIS. This case only exists to work around SwiftUI bugs.
        case checkoutSimplified
        
        static func == (lhs: State, rhs: State) -> Bool {
            switch (lhs, rhs) {
            case (.summary, .summary):
                return true
            case (.confirmed, .confirmed):
                return true
            case (.checkoutSimplified, .checkout):
                return true
            case (.checkout, .checkoutSimplified):
                return true
            default:
                return false
            }
        }
    }

    // MARK: Internal

    @Published var state: State = .summary

}

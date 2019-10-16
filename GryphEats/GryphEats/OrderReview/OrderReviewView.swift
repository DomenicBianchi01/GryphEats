//
//  OrderReviewView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-15.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - OrderReviewView

struct OrderReviewView: View {
    
    // MARK: Internal
    
    var body: some View {
        HStack {
            if state.state == .summary {
                OrderSummaryView().transition(.leftSlide)
            } else if state.state == .checkoutSimplified {
                // SwiftUI Bug: Since we need to extract the payment option from `.checkout` (the associated value),
                // we would need to use a `switch` or `if-case`. These cannot be used within the `body` (the SwiftUI
                // bug) so we need to use a private property that extracts the value for us. I could have made another
                // private variable that returns AnyView and uses a switch, however, when doing so, the custom
                // transitions would not work (another SwiftUI bug?)
                CheckoutView(paymentOption: paymentOption).transition(.rightSlide)
            } else if state.state == .confirmed {
                OrderSubmittedView().transition(.rightSlide)
            }
        }.background(Rectangle()
            .fill(Color.lightGray)
            .edgesIgnoringSafeArea(.all))
    }
    
    // MARK: Private
    
    @EnvironmentObject private var state: OrderReviewState
    
    private var paymentOption: PaymentOption {
        if case let .checkout(paymentOption) = state.state {
            return paymentOption
        } else {
            // No-op
            return .credit
        }
    }
    
}

struct OrderReviewView_Previews: PreviewProvider {
    static var previews: some View {
        OrderReviewView().environmentObject(OrderReviewState())
    }
}

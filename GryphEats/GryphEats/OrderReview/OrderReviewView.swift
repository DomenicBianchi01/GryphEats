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
            } else if state.state == .checkout {
                CheckoutView().transition(.rightSlide)
            }
        }.background(Rectangle()
            .fill(Color.lightGray)
            .edgesIgnoringSafeArea(.all))
    }

    // MARK: Private

    @EnvironmentObject private var state: OrderReviewState

}

struct OrderReviewView_Previews: PreviewProvider {
    static var previews: some View {
        OrderReviewView().environmentObject(OrderReviewState())
    }
}

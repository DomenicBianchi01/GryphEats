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
        VStack(spacing: 0) {
            HStack {
                if state.state == .checkout {
                    BackButton(color: .blue) {
                        withAnimation {
                            self.state.state = .summary
                        }
                    }
                }
                Spacer()
                Button(action: {
                    self.viewControllerHolder.value?.dismiss(animated: true)
                }) {
                    Image(systemName: "xmark")
                }.padding()
            }
            
            if state.state == .summary {
                OrderSummaryView().transition(.leftSlide)
            } else if state.state == .checkout {
                // SwiftUI Bug: Since we need to extract the payment option from `.checkout` (the associated value),
                // we would need to use a `switch` or `if-case`. These cannot be used within the `body` (the SwiftUI
                // bug) so we need to use a private property that extracts the value for us. I could have made another
                // private variable that returns AnyView and uses a switch, however, when doing so, the custom
                // transitions would not work (another SwiftUI bug?)
                CheckoutView().transition(.rightSlide)
            } else if state.state == .confirmed {
                OrderSubmittedView().transition(.rightSlide)
            }
        }.background(Rectangle()
            .fill(Color.lightGray(for: colorScheme))
            .edgesIgnoringSafeArea(.all))
    }
    
    // MARK: Private
    
    @EnvironmentObject private var state: OrderReviewState
    @Environment(\.viewController) private var viewControllerHolder
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
}

struct OrderReviewView_Previews: PreviewProvider {
    static var previews: some View {
        OrderReviewView().environmentObject(OrderReviewState())
    }
}

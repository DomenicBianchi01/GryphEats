//
//  CheckoutView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-15.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI
import PassKit

// MARK: - CheckoutView

struct CheckoutView: View {
    
    // MARK: Lifecycle
    
    init(paymentOption: PaymentOption) {
        self.viewModel = CheckoutViewModel(paymentOption: paymentOption)
    }
    
    // MARK: Internal
    
    var body: some View {
        ScrollView {
            VStack {
                BackButton(color: .blue) {
                    withAnimation {
                        self.state.state = .summary
                    }
                }
                
                cardView
                
                PriceSummaryCard(displayMode: .onCampusMealPlan) { action in
                    if case .confirmPayment = action {
                        self.confirmPayment = true
                    }
                }
                
                Spacer()
            }
        }.alert(isPresented: $confirmPayment) {
            Alert(
                title: Text("Confirm Payment"),
                message: Text("Once your confirm your payment, your order will begin to be prepared."),
                primaryButton: .default(Text("Confirm")) {
                    withAnimation {
                        self.state.state = .confirmed
                        self.cart.clear()
                    }
                },
                secondaryButton: .cancel {
                    self.confirmPayment = false
                })
        }
    }
    
    // MARK: Private
    
    @EnvironmentObject private var cart: Cart
    @EnvironmentObject private var state: OrderReviewState
    
    @State private var confirmPayment: Bool = false
    
    private let viewModel: CheckoutViewModel
    
    private var cardView: AnyView {
        switch viewModel.paymentOption {
        case .studentCard:
            return AnyView(StudentCard(name: "Domenic Bianchi", studentNumber: "0921557", balance: 5000))
        case .credit:
            return AnyView(StudentCard(name: "Domenic Bianchi", studentNumber: "0921557", balance: 5000))
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView(
            paymentOption: .studentCard)
            .environmentObject(Cart(items: [
                FoodItem(id: 0, name: "Hamburger", imageName: ""),
                FoodItem(id: 0, name: "Hamburger", imageName: "")
            ]))
            .environmentObject(OrderReviewState())
    }
}

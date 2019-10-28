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
                
                // This view is refreshed `onAppear`. If the number of payment methods have increased or decreased,
                // because we are iterating over the indices and not the actual objects, we need to provide a unique
                // identifier for the actual index (since we don't have access to `Identifiable` within the actual
                // payment method object).
                ForEach(viewModel.paymentMethods.indices, id: \.hashValue) { index in
                    PaymentSelectionCard(
                        paymentMethod: self.viewModel.paymentMethods[index],
                        isSelected: self.selectedPaymentMethodIndex == index)
                    {
                        self.selectedPaymentMethodIndex = index
                    }
                }
                
                if viewModel.paymentMethods.isEmpty {
                    Text("No payment methods found.").bold()
                }
                
                Button(action: {
                    self.showAddPayment = true
                }) {
                    Text("Add Payment Method")
                        .foregroundColor(.guelphRed)
                }.padding()
                
                Divider().padding([.horizontal, .bottom])
                
                PriceSummaryCard(
                    displayMode: priceSummaryDisplayMode ?? .noDiscounts,
                    isPayButtonDisabled: viewModel.paymentMethods.isEmpty)
                { action in
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
                        self.viewModel.submitPayment(for: self.cart) { result in
                            switch result {
                            case .success:
                                self.state.state = .confirmed
                                self.cart.clear()
                            case .failure(let error):
                                self.error = error
                            }
                        }
                    }
                },
                secondaryButton: .cancel {
                    self.confirmPayment = false
                })
        }.sheet(isPresented: $showAddPayment) {
            AddPaymentView()
        }.onAppear {
            self.forceRefresh = true
        }
    }
    
    // MARK: Private
    
    @EnvironmentObject private var cart: Cart
    @EnvironmentObject private var state: OrderReviewState
    
    @State private var showAddPayment: Bool = false
    @State private var confirmPayment: Bool = false
    @State private var selectedPaymentMethodIndex = 0
    @State private var error: CheckoutViewModel.PaymentError? = nil
    
    // TODO: Find a better way to refresh the view.
    // After adding a new payment, we need to refresh the view to reflect the new list of payment methods. The only
    // way I currently know how to do this is to set a dummy `@State` property to force a refresh.
    @State private var forceRefresh: Bool = false
    
    private let viewModel = CheckoutViewModel()
    
    private var cardView: AnyView? {
        guard !viewModel.paymentMethods.isEmpty else {
            return nil
        }
        
        let paymentMethod = viewModel.paymentMethods[selectedPaymentMethodIndex]
        switch paymentMethod.cardType {
        case .student:
            return AnyView(StudentCard(
                name: "Domenic Bianchi",
                studentNumber: String(paymentMethod.accountNumber),
                balance: 5000))
        case .visa:
            return AnyView(CreditCard(brand: .visa, lastFourDigits: paymentMethod.lastFourDigits))
        case .mastercard:
            return AnyView(CreditCard(brand: .mastercard, lastFourDigits: paymentMethod.lastFourDigits))
        }
    }
    
    var priceSummaryDisplayMode: PriceSummaryCard.DisplayMode? {
        guard !viewModel.paymentMethods.isEmpty else {
            return nil
        }
        
        switch viewModel.paymentMethods[selectedPaymentMethodIndex].cardType {
        case .student(let mealPlanType):
            return mealPlanType == .onCampus ? .onCampusMealPlan : .ultraMealPlan
        case .visa, .mastercard:
            return .noDiscounts
        }
    }
}

struct CheckoutView_Previews: PreviewProvider {
    static var previews: some View {
        CheckoutView()
            .environmentObject(Cart(items: [
                GraphFoodItem(id: "1", displayName: "Hamburger 1", price: 2),
                GraphFoodItem(id: "2", displayName: "Hamburger 2", price: 2)
            ]))
            .environmentObject(OrderReviewState())
    }
}

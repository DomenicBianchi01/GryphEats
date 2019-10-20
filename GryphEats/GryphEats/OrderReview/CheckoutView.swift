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
                
                ForEach(viewModel.paymentMethods.indices) { index in
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
                
                PriceSummaryCard(
                    displayMode: priceSummaryDisplayMode ?? .noDiscounts,
                    isPayButtonDisabled: viewModel.paymentMethods.isEmpty)
                { action in
                    if case .confirmPayment = action {
                        self.confirmPayment = true
                    }
                }.padding(.top, 40)
                
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
        }.sheet(isPresented: $showAddPayment) {
            AddPaymentView()
        }
    }
    
    // MARK: Private
    
    @EnvironmentObject private var cart: Cart
    @EnvironmentObject private var state: OrderReviewState
    
    @State private var showAddPayment: Bool = false
    @State private var confirmPayment: Bool = false
    @State private var selectedPaymentMethodIndex = 0
    
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
                FoodItem(id: 0, name: "Hamburger", imageName: ""),
                FoodItem(id: 0, name: "Hamburger", imageName: "")
            ]))
            .environmentObject(OrderReviewState())
    }
}

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
                cardView
                
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
                        .foregroundColor(.guelphRed(for: colorScheme))
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
                    self.viewModel.submitOrder(for: self.loggedInUser.id, with: self.cart) { result in
                        switch result {
                        case .success:
                            withAnimation {
                                self.state.state = .confirmed
                                self.cart.clear()
                            }
                        case .failure(let error):
                            self.error = error
                        }
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
    
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    @EnvironmentObject private var loggedInUser: User
    @EnvironmentObject private var cart: Cart
    @EnvironmentObject private var state: OrderReviewState
    
    @State private var showAddPayment: Bool = false
    @State private var confirmPayment: Bool = false
    @State private var selectedPaymentMethodIndex = 0
    @State private var error: CheckoutViewModel.OrderSubmissionError? = nil
    
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
            return AnyView(CreditCard(cardProvider: .visa, lastFourDigits: paymentMethod.lastFourDigits))
        case .mastercard:
            return AnyView(CreditCard(cardProvider: .mastercard, lastFourDigits: paymentMethod.lastFourDigits))
        }
    }
    
    private var priceSummaryDisplayMode: PriceSummaryCard.DisplayMode? {
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
                RestaurantFoodItem(
                    foodItem: GraphFoodItem(id: "1", name: "Hamburger 1", price: 2),
                    restaurantId: "1",
                    restaurantName: "100 Mile Grill"),
                RestaurantFoodItem(
                    foodItem: GraphFoodItem(id: "2", name: "Hamburger 2", price: 2),
                    restaurantId: "1",
                    restaurantName: "100 Mile Grill")
            ]))
            .environmentObject(OrderReviewState())
            .environmentObject(User(id: "1", type: .customer, username: "", password: ""))
    }
}

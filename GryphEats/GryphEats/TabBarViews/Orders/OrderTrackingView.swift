//
//  OrderTrackingView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-31.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - OrderTrackingView

struct OrderTrackingView: View, Dismissable {
    
    // MARK: Lifecycle
    
    init(order: Order, onDismiss: @escaping () -> Void) {
        self.viewModel = OrderTrackingViewModel(order: order)
        self.onDismiss = onDismiss
    }
    
    // MARK: Internal
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Order Details")
                    .bold()
                    .padding(.bottom, 10)
                    .padding(.top, 25)
                
                OrderStatusBar(status: viewModel.order.status, cancelAction: {
                    self.viewModel.cancelOrder { success in
                        if success {
                            self.onDismiss()
                            self.dismiss()
                        } else {
                            self.error = .cancelError
                        }
                    }
                }, reorderAction: {
                    self.showReorderInterface = true
                }).padding(.vertical)
                
                sectionHeader(title: "Items")
                
                ForEach(viewModel.order.items, id: \.foodItem.id) { item in
                    CartItemCard(item: item)
                }
                
                if viewModel.order.specialInstructions != nil {
                    sectionHeader(title: "Special Instructions").padding(.top)
                    TextView(text: .constant(viewModel.order.specialInstructions!), isEditable: false)
                        .background(Color.white)
                        .cornerRadius(5)
                        .padding([.horizontal], 10)
                        .shadow(radius: 2)
                        .frame(width: UIScreen.main.bounds.size.width)
                        .fixedSize(horizontal: true, vertical: false)
                }
                
                sectionHeader(title: "Summary").padding(.top)
                
                PriceSummaryCard(displayMode: priceSummaryCardDisplayMode, isPayButtonHidden: true) { _ in }
                    .environmentObject(Cart(items: viewModel.order.items))
            }
        }.errorAlert(error: self.$error.wrappedValue) {
            // If we do not "unset" the error, and assign an error that is the exact same type of the
            //old value, SwiftUI will not present the alert. Possible SwiftUI Bug?
            self.error = nil
        }.sheet(isPresented: $showReorderInterface) {
            OrderReviewView(showDismissButton: false)
                .environmentObject(Cart(items: self.viewModel.order.items))
                .environmentObject(self.loggedInUser)
                .environmentObject(OrderReviewState())
        }.onDisappear {
            self.onDismiss()
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject private var loggedInUser: User
    
    // MARK: Private
    
    @State private var error: OrderTrackingViewModel.OrderTrackingError? = nil
    @State private var showReorderInterface: Bool = false
    
    private let viewModel: OrderTrackingViewModel
    private let onDismiss: () -> Void
    
    private var priceSummaryCardDisplayMode: PriceSummaryCard.DisplayMode {
        switch viewModel.order.paymentType {
        case .credit:
            return .noDiscounts
        case .oncampus:
            return .onCampusMealPlan
        case .offcampus:
            return .ultraMealPlan
        default:
            return .noDiscounts
        }
    }
    
    private func sectionHeader(title: String) -> some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            Spacer()
        }
    }
}

struct OrderTrackingView_Previews: PreviewProvider {
    static var previews: some View {
        OrderTrackingView(
            order: Order(
                id: "0",
                restaurantID: "1",
                customer: Customer(name: ""),
                status: .neworder,
                timePlaced: "12:00pm",
                paymentType: .credit,
                items: [RestaurantFoodItem(
                    foodItem: GraphFoodItem(id: "0", name: "Hamburger 1", price: 9.99, inStock: true),
                    restaurantId: "1",
                    restaurantName: "100 Mile Grill")])) {}
    }
}

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
                
                OrderStatusBar(status: viewModel.order.status) {
                    self.viewModel.cancelOrder { success in
                        if success {
                            self.onDismiss()
                            self.dismiss()
                        } else {
                            self.error = .cancelError
                        }
                    }
                }.padding(.vertical)
                
                ForEach(viewModel.order.items, id: \.foodItem.id) { item in
                    CartItemCard(item: item)
                }
                
                PriceSummaryCard(displayMode: .onCampusMealPlan, isPayButtonHidden: true) { _ in }
                    .environmentObject(Cart(items: viewModel.order.items))
            }
        }.errorAlert(error: self.$error.wrappedValue) {
            // If we do not "unset" the error, and assign an error that is the exact same type of the
            //old value, SwiftUI will not present the alert. Possible SwiftUI Bug?
            self.error = nil
        }
    }
    
    @Environment(\.presentationMode) var presentationMode
    
    // MARK: Private
    
    @State private var error: OrderTrackingViewModel.OrderTrackingError? = nil
    
    private let viewModel: OrderTrackingViewModel
    private let onDismiss: () -> Void
    
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
                items: [RestaurantFoodItem(
                    foodItem: GraphFoodItem(id: "0", name: "Hamburger 1", price: 9.99),
                    restaurantId: "1",
                    restaurantName: "100 Mile Grill")])) {}
    }
}

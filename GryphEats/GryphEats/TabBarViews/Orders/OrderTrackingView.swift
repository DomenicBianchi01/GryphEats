//
//  OrderTrackingView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-31.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - OrderTrackingView

struct OrderTrackingView: View {
    
    // MARK: Lifecycle
    
    init(order: Order) {
        self.order = order
    }
    
    // MARK: Internal
    
    var body: some View {
        ScrollView {
            VStack {
                Text("Order Details")
                    .bold()
                    .padding(.bottom, 10)
                    .padding(.top, 25)
                
                OrderStatusBar(status: order.status)
                    .padding(.vertical)
                
                ForEach(order.items, id: \.foodItem.id) { item in
                    CartItemCard(item: item)
                }
                
                PriceSummaryCard(displayMode: .onCampusMealPlan, isPayButtonHidden: true) { _ in }
                    .environmentObject(Cart(items: order.items))
            }
        }
    }
    
    // MARK: Private
    
    private let order: Order
    
}

struct OrderTrackingView_Previews: PreviewProvider {
    static var previews: some View {
        OrderTrackingView(
            order: Order(
                id: 0,
                customer: Customer(name: ""),
                status: .new,
                timePlaced: "12:00pm",
                items: [RestaurantFoodItem(
                    foodItem: GraphFoodItem(id: "0", displayName: "Hamburger 1", price: 9.99),
                    restaurantId: "1",
                    restaurantName: "100 Mile Grill")]))
    }
}

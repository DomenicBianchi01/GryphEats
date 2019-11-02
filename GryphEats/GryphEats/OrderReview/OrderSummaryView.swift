//
//  OrderSummaryView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-10.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - OrderSummaryView

struct OrderSummaryView: View {
    
    // MARK: Lifecycle
    
    init() {
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .lightGray
    }
    
    // MARK: Internal
    
    var body: some View {
        // SwiftUI Bug: Using a `List` instead of a `ScrollView` causes weird behavior for the payment screen
        // (displayed after this screen)
        ScrollView {
            VStack(spacing: 0) {
                Group {
                    Image(systemName: "cart")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.top, 25)
                        .padding(.bottom, 5)
                    Text("Summary")
                        .bold()
                        .padding(.bottom, 10)
                }.foregroundColor(.guelphRed)
                
                ForEach(cart.items, id: \.foodItem.id) { item in
                    CartItemCard(item: item) {
                        self.cart.delete(item: item)
                    }
                }
                
                if cart.items.isEmpty {
                    HStack {
                        Spacer()
                        Text("Cart is empty!")
                            .padding(.top, 30)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                } else {
                    PriceSummaryCard { action in
                        switch action {
                        case .creditOrStudentCard:
                            withAnimation {
                                self.state.state = .checkout
                            }
                        case .applePay:
                            break
                        default:
                            break
                        }
                    }
                }
                
                Spacer()
            }
        }
    }
    
    // MARK: Private
    
    @EnvironmentObject private var cart: Cart
    @EnvironmentObject private var state: OrderReviewState
    
}

struct OrderSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        OrderSummaryView()
            .environmentObject(Cart(items: [
                RestaurantFoodItem(
                    foodItem: GraphFoodItem(id: "1", name: "Hamburger 1", price: 2),
                    restaurantId: "1",
                    restaurantName: "100 Mile Grill"),
                RestaurantFoodItem(
                    foodItem: GraphFoodItem(id: "2", name: "Hamburger 2", price: 2),
                    restaurantId: "1",
                    restaurantName: "100 Mile Grill"),
            ]))
            .environmentObject(OrderReviewState())
    }
}

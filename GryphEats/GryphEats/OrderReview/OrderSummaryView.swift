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
                
                ForEach(cart.items, id: \.id) { item in
                    self.itemCard(for: item)
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
    
    private func itemCard(for item: GraphFoodItem) -> CartItemCard {
        let editAction = {
            print("t")
        }
        
        let deleteAction: () -> Void = {
            self.cart.delete(item: item)
        }
        
        return CartItemCard(item: item, editAction: editAction, deleteAction: deleteAction)
    }
}

struct OrderSummaryView_Previews: PreviewProvider {
    static var previews: some View {
        OrderSummaryView()
            .environmentObject(Cart(items: [
                GraphFoodItem(id: "1", displayName: "Hamburger 1", price: 2),
                GraphFoodItem(id: "2", displayName: "Hamburger 2", price: 2)
            ]))
            .environmentObject(OrderReviewState())
    }
}

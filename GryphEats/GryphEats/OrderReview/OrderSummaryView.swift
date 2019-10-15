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
    
    // MARK: Internal
    
    var body: some View {
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
                
                ForEach(cart.items) { item in
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
                    PriceSummaryCard()
                }
                
                Spacer()
            }
        }
    }
    
    // MARK: Private
    
    @EnvironmentObject private var cart: Cart
    @EnvironmentObject private var state: OrderReviewState
    
    private func itemCard(for item: FoodItem) -> some View {
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
                FoodItem(id: 0, name: "Hamburger", imageName: ""),
                FoodItem(id: 0, name: "Hamburger", imageName: "")
            ]))
            .environmentObject(OrderReviewState())
    }
}
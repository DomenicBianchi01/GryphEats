//
//  CheckoutView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-15.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - CheckoutView

struct CheckoutView: View {
    
    // MARK: Internal
    
    var body: some View {
        HStack {
            Spacer()
            VStack {
                BackButton(color: .blue) {
                    withAnimation {
                        self.state.state = .summary
                    }
                }.foregroundColor(.blue)
                
                Text(/*@START_MENU_TOKEN@*/"Hello World!"/*@END_MENU_TOKEN@*/)
                Spacer()
            }
            Spacer()
        }
    }
    
    // MARK: Private
    
    @EnvironmentObject private var cart: Cart
    @EnvironmentObject private var state: OrderReviewState
    
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

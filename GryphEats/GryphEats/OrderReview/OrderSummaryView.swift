//
//  OrderSummaryView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-10.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import PassKit
import SwiftUI

// MARK: - OrderSummaryView

struct OrderSummaryView: View {
    
    // MARK: Lifecycle
    
    init(isDismissButtonVisible: Bool = true) {
        self.isDismissButtonVisible = isDismissButtonVisible
        
        UITableView.appearance().separatorStyle = .none
        UITableView.appearance().backgroundColor = .lightGray
    }
    
    // MARK: Internal
    
    var body: some View {
        // SwiftUI Bug: Using a `List` instead of a `ScrollView` causes weird behavior for the payment screen
        // (displayed after this screen)
        ScrollView {
            VStack {
                Group {
                    Image(systemName: "cart")
                        .resizable()
                        .frame(width: 50, height: 50)
                        .padding(.top, isDismissButtonVisible ? 0 : 25)
                        .padding(.bottom, 5)
                    Text("Summary")
                        .bold()
                        .padding(.bottom, 10)
                }.foregroundColor(.guelphRed(for: colorScheme))
                
                if cart.items.isEmpty {
                    HStack {
                        Spacer()
                        Text("Cart is empty!")
                            .padding(.top, 30)
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                } else {
                    sectionHeader(title: "Items")
                    
                    ForEach(cart.items, id: \.foodItem.id) { item in
                        CartItemCard(item: item) {
                            self.cart.delete(item: item)
                        }
                    }
                    
                    sectionHeader(title: "Special Instructions").padding(.top)
                    
                    // TODO Bug: Lines do not word wrap automatically for some reason
                    TextView(text: self.$cart.specialInstructions)
                        .background(Color.white)
                        .cornerRadius(5)
                        .padding(.horizontal, 10)
                        .shadow(radius: 2)
                        .frame(width: UIScreen.main.bounds.size.width)
                        .fixedSize(horizontal: true, vertical: false)
                        .dismissKeyboardOnTapGesture()
                    
                    sectionHeader(title: "Summary").padding(.top)
                    
                    PriceSummaryCard { action in
                        switch action {
                        case .creditOrStudentCard:
                            withAnimation {
                                self.state.state = .checkout
                            }
                        case .applePay:
                            self.promptApplePay()
                        default:
                            break
                        }
                    }
                }
                
                Spacer()
            }
        }.dismissKeyboardOnTapGesture()
    }
    
    // MARK: Private
    
    @Environment(\.viewController) private var viewControllerHolder
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    @EnvironmentObject private var cart: Cart
    @EnvironmentObject private var state: OrderReviewState
    
    private let viewModel = OrderSummaryViewModel()
    private let isDismissButtonVisible: Bool
    
    private func sectionHeader(title: String) -> some View {
        HStack {
            Text(title)
                .font(.headline)
                .foregroundColor(.secondary)
                .padding(.horizontal)
            Spacer()
        }
    }
    
    private func promptApplePay() {
        let applePayController = viewModel.promptApplePay(for: cart) { success in
            if success {
                withAnimation {
                    self.state.state = .confirmed
                    self.cart.clear()
                }
            }
        }
        
        guard let viewController = applePayController else {
            return
        }
        
        viewControllerHolder.value?.present(viewController, animated: true, completion: nil)
    }
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

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
                        CartItemCard(
                            item: item,
                            editAction: {
                                OrderSummaryView.itemToEdit = item
                                self.displayEditItem = true
                        }, deleteAction: {
                            self.cart.delete(item: item)
                        })
                    }
                    
                    sectionHeader(title: "Special Instructions").padding(.top)
                    
                    // TODO Bug: Lines do not word wrap automatically for some reason
                    TextView(text: self.$cart.specialInstructions.safelyUnwrapped)
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
        }.sheet(isPresented: $displayEditItem) {
            ItemOverview(item: OrderSummaryView.itemToEdit!, displayMode: .edit)
                .environmentObject(self.cart)
        }.dismissKeyboardOnTapGesture()
    }
    
    // MARK: Private
    
    @Environment(\.viewController) private var viewControllerHolder
    @Environment(\.colorScheme) private var colorScheme: ColorScheme
    
    @EnvironmentObject private var loggedInUser: User
    @EnvironmentObject private var cart: Cart
    @EnvironmentObject private var state: OrderReviewState
    
    @State private var error: OrderSummaryViewModel.OrderSubmissionError? = nil
    @State private var displayEditItem = false
    
    private let viewModel = OrderSummaryViewModel()
    private let isDismissButtonVisible: Bool
    
    // A terrible hack...
    static private var itemToEdit: RestaurantFoodItem? = nil
    
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
                self.viewModel.submitOrder(for: self.loggedInUser.id, with: self.cart, using: .credit) { result in
                    switch result {
                    case .success(let orderDetails):
                        withAnimation {
                            self.state.state = .confirmed(numberOfOrders: orderDetails.numberOfOrders)
                            self.cart.clear()
                        }
                    case .failure(let error):
                        self.error = error
                    }
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
                    foodItem: FoodItemDetails(id: "1", name: "Hamburger 1", price: 2, inStock: true),
                    restaurantId: "1",
                    restaurantName: "100 Mile Grill"),
                RestaurantFoodItem(
                    foodItem: FoodItemDetails(id: "2", name: "Hamburger 2", price: 2, inStock: true),
                    restaurantId: "1",
                    restaurantName: "100 Mile Grill"),
            ]))
            .environmentObject(OrderReviewState())
    }
}

//
//  OrdersView.swift
//  GryphEats
//
//  Created by Domenic Bianchi on 2019-10-23.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

// MARK: - OrdersView

struct OrdersView: View {
    
    // MARK: Internal
    
    var body: some View {
        NavigationHeaderView(
            title: "Orders",
            navigationColor: .guelphYellow,
            contentBackgroundColor: .lightGray)
        {
            self.content
        }.sheet(
            isPresented: .constant($selectedOrder.wrappedValue != nil),
            onDismiss: {
                self.selectedOrder = nil
        }) {
            OrderTrackingView(order: self.selectedOrder!)
        }.onAppear {
            UITableView.appearance().separatorStyle = .none
            UITableView.appearance().backgroundColor = .lightGray
            self.viewModel.fetchOrders()
        }
    }
    
    // MARK: Private
    
    @State private var selectedOrder: Order? = nil
    @ObservedObject private var viewModel = OrdersViewModel()
    
    private var content: AnyView {
        switch viewModel.loadingState {
        case .loading:
            return AnyView(VStack {
                Spacer()
                ActivityIndicator(style: .large)
                Spacer()
            })
        case .loaded(let orders):
            // Swift UI Bug: `listRowBackground` and `listRowInsets` do not work without nesting a `ForEach` within
            // `List`
            return AnyView(List {
                ForEach(orders) { order in
                    OrderHistoryCard(order: order).onTapGesture {
                        self.selectedOrder = order
                    }
                }.listConfiguration(backgroundColor: Color.lightGray)
            })
        case .error:
            return AnyView(ErrorView(infoText: "Whoops! We could not fetch your orders.", buttonText: "Try Again") {
                self.viewModel.fetchOrders()
            })
        }
    }
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}

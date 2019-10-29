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
            // Swift UI Bug: `listRowBackground` and `listRowInsets` do not work without nesting a `ForEach` within
            // `List`
            List {
                ForEach(self.orders) { order in
                    OrderHistoryCard(order: order).onTapGesture {
                        self.selectedOrder = order
                    }
                }.listConfiguration(backgroundColor: Color.lightGray)
            }
        }.sheet(
            isPresented: .constant($selectedOrder.wrappedValue != nil),
            onDismiss: {
                self.selectedOrder = nil
        }) {
            Text(String(self.$selectedOrder.wrappedValue?.id ?? -1))
        }.onAppear {
            UITableView.appearance().separatorStyle = .none
            UITableView.appearance().backgroundColor = .lightGray
        }
    }
    
    let orders = [
        Order(id: 1, customer: Customer(name: "Test"), status: .new, time: "12:00pm"),
        Order(id: 2, customer: Customer(name: "Test"), status: .inProgress, time: "12:00pm"),
        Order(id: 3, customer: Customer(name: "Test"), status: .readyForPickup, time: "12:00pm"),
        Order(id: 4, customer: Customer(name: "Test"), status: .pickedUp, time: "12:00pm")
    ]
    
    // MARK: Private
    
    @State private var selectedOrder: Order? = nil
    
}

struct OrdersView_Previews: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}

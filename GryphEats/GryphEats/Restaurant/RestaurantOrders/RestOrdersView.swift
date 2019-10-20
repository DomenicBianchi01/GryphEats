//
//  RestOrdersView.swift
//  GryphEats
//
//  Created by Matthew Bebis on 10/10/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

struct RestOrdersView: View {
    
    var orders: [Order]
    @State var isSelected = false
    
    init(orders: [Order]) {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "Roboto-Bold", size: 42)!]
        UINavigationBar.appearance().titleTextAttributes = [.font : UIFont(name: "Roboto-Bold", size: 30)!]
        self.orders = orders
    }
    
    var body: some View {
        NavigationView {
            List {
                ForEach(orders) { order in
                    NavigationLink(destination: OrderDetailsView(order: order).navigationBarTitle("Order Details")) {
                        OrderCard(order: order, enableShadow: false, isCollapsable: false, fillSpace: true)
                    }
                }
            }.navigationBarTitle("Orders")
            Text("Select an order from the list to get started")
        }.onAppear() {
            UITableView.appearance().separatorColor = .clear
        }.onDisappear() {
            UITableView.appearance().separatorColor = .separator
        }
    }
}

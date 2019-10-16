//
//  OrdersNavigation.swift
//  GryphEats
//
//  Created by Matthew Bebis on 10/10/19.
//  Copyright © 2019 The Subway Squad. All rights reserved.
//

import SwiftUI

struct OrdersView: View {
    var body: some View {
        NavigationView {
            List (0..<5) { item in
                OrderRow()
            }.navigationBarTitle("Orders", displayMode: .large)
        }.navigationViewStyle(StackNavigationViewStyle())
    }
}

struct OrdersView_preview: PreviewProvider {
    static var previews: some View {
        OrdersView()
    }
}
